class ProfilesController < ApplicationController
  def show
  	@author = Author.find(params[:id])
  end
end
