class StaticPagesController < ApplicationController

	def home
    if logged_in?
      @gossip     = current_user.gossips.build
      # .with_attached_picture (avoid N + 1 queries)... may find something more appropriated
      @feed_items = current_user.feed.paginate(page: params[:page]).with_attached_picture
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
