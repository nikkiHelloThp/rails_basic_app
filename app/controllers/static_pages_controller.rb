class StaticPagesController < ApplicationController

	def home
	end
	
  def contact
  end

  def team
  end

  def welcome
  	@name = params[:name]
  end
end
