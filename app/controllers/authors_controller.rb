class AuthorsController < ApplicationController
  
  before_action :logged_in_user?, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  
  def index
    @authors = Author.paginate(page: params[:page])
  end

  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end

  def create
  	@author = Author.new(author_params)
  	if @author.save
      log_in @author
  		flash[:success] = "Account successfully created"
  		redirect_to @author
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
      params.require(:author).permit(:name, :email, :password, :password_confirmation) # test :admin
    end

    # before_filters

    def logged_in_user?
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end

    def correct_user
      @author = Author.find(params[:id])
      redirect_to(root_url) unless current_user?(@author)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
