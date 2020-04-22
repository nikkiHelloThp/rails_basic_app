class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
  	@author = Author.find_by(email: params[:password_reset][:email])
  	if @author
  		@author.create_password_reset_digest
  		@author.send_password_reset_email
  		flash[:info] = "Email sent with password reset instructions"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if password_blank?
      flash.now[:danger] = "Password cannot be blank"
      render 'edit'
    elsif @author.update_attributes(author_params)
      log_in @author
      flash[:success] = "Password has been reset"
      redirect_to @author
    else
      render 'edit'
    end
  end


  private

    def author_params
      params.require(:author).permit(:password, :password_confirmation)
    end

    # Return true if password is blank
    def password_blank?
      params[:author][:password].blank?
    end

    # Before filters

    def get_user
      @author = Author.find_by(email: params[:email])
    end

    # Confirms a valid user
    def valid_user
      unless (@author && @author.activated? &&
              @author.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token
    def check_expiration
      if @author.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
