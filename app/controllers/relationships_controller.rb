class RelationshipsController < ApplicationController
	before_action :logged_in_user?

	def create
		@author = Author.find(params[:followed_id])
		current_user.follow(@author)
		respond_to do |format|
			format.html { redirect_to @author }
			format.js
		end
	end

	def destroy
		@author = Relationship.find(params[:id]).followed
		current_user.unfollow(@author)
		respond_to do |format|
			format.html { redirect_to @author }
			format.js
		end
	end
end
