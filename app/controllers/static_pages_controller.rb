class StaticPagesController < ApplicationController

	def home
    if logged_in?
      @gossip     = current_user.gossips.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end 
  end
	
  def contact
  end

  def team
  end

  def welcome
  	@name = params[:name]
  end
end
