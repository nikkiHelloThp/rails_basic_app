class AuthorsController < ApplicationController
  
  def new
    @author = Author.new
  end

  def create
  	@author = Author.new(author_params)
  	if @author.save
  		flash[:success] = "Account successfully created"
  		redirect_to profile_url(@author)
  	else
  		render :new
  	end
  end

  def destroy
  end


  private

    def author_params
      params.require(:author).permit(:name, :email, :password, :password_confirmation)
    end
end
