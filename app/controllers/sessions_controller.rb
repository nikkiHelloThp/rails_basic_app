class SessionsController < ApplicationController
  def new
  end

  def create
  	user = Author.find_by(email: params[:email])
  	if user && user.authenticate(params[:password])
  		log_in(user)
			flash[:success] = "Connexion reussi!"
      if params[:remember_me] == "1"
        remember(user)
      flash[:notice] = "Nous nous souviendrons de vous!"
      else
        forget(user)
      flash[:notice] = "Nous NE nous souviendrons PAS de vous!"
      end
			redirect_to gossips_path
  	else
			flash.now[:danger] = "Log in Fail!"
			render :new
  	end
  end

  def destroy
  	log_out if logged_in?
  	flash[:success] = "You successfully loged out!"
		redirect_to gossips_path
  end
end
