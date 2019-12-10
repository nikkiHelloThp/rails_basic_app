class AuthorsController < ApplicationController
  def new
  end

  def create
  	author = Author.new(
  						email: params[:email],
  						password: params[:password]
  					)
  	if author.save
  		flash[:success] = "Utilisateur cree avec succes!"
  		redirect_to gossips_path
  	else
  		flash.now[:danger] = "#{author.errors.full_messages[0]}"
  		render :new
  	end
  end

  def destroy
  end
end
