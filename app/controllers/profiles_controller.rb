class ProfilesController < ApplicationController
	# before_action :authenticate_user
  def show
  	@author = Author.find(params[:id])
  end
end
