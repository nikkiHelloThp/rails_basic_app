class AuthorsController < ApplicationController
  
  def new
    @author = Author.new
  end

  def create
  	@author = Author.new(author_params)
  	if @author.save
  		flash[:success] = "Utilisateur cree avec succes!"
  		redirect_to gossips_path
  	else
  		render :new
  	end
  end

  def destroy
  end


  private

    def author_params
      params.require(:author).permit(:email, :password, :password_confirmation)
    end
end
