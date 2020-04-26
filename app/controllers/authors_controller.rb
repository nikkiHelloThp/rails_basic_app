class AuthorsController < ApplicationController
  
  before_action :logged_in_user?, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  
  def index
    @authors = Author.active.paginate(page: params[:page])
  end

  def show
    @author = Author.find(params[:id])
    @gossips = @author.gossips.paginate(page: params[:page])
    redirect_to root_url and return unless @author.activated?
  end
  
  def new
    @author = Author.new
  end

  def create
  	@author = Author.new(author_params)
  	if @author.save
      @author.send_activation_email
  		flash[:info] = "Please check your email to activate your account."
  		redirect_to root_url
  	else
  		render :new
  	end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Author deleted"
    redirect_to authors_url
  end

  def edit
  end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = "Profile updated"
      redirect_to @author
    else
      render :edit
    end
  end


  private

    def author_params
      params.require(:author).permit(:name, :email, :password, :password_confirmation)
    end

    # before_filters

    def correct_user
      @author = Author.find(params[:id])
      redirect_to(root_url) unless current_user?(@author)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
