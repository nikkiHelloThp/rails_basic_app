class AuthorsController < ApplicationController
  
  before_action :logged_in_user?, only: [:index, :edit, :update, :destroy,
                                         :following, :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy
  before_action :get_author,      only: [:show, :destroy, :following, :followers]
  def index
    @authors = Author.active.paginate(page: params[:page])
  end

  def show
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
    @author.destroy
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

  def following
    @title = "Following "
    @authors = @author.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers "
    @authors = @author.followers.paginate(page: params[:page])
    render "show_follow"
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

    def get_author
      @author = Author.find(params[:id]) 
    end
end
