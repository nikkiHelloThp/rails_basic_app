class WelcomeController < ApplicationController
  def index
  	puts "#" * 80
  	@name = params[:name]
  end
end
