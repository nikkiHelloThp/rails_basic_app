class StaticPagesController < ApplicationController
	
  def contact
  end

  def team
  end

  def welcome
  	@name = params[:name]
  end
end
