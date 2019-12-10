class CitiesController < ApplicationController
  def show
  	@city = City.find(params[:id])
  	@author = @city.authors
  end
end
