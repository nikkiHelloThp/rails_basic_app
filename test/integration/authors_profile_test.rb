require 'test_helper'

class AuthorsProfileTest < ActionDispatch::IntegrationTest
	def setup
		@author = authors(:one)
	end

	test "profile display" do
		get author_path(@author)
		assert_template 'authors/show'
		base_title		= "| TheGossipProject"
		resource_name	= "#{@request.params[:controller].capitalize.singularize}"
		assert_select "title", "#{@author.name} #{resource_name} #{base_title}"
		assert_select "h1", text: @author.name
		assert_select "h1>img.gravatar"
		assert_match "Gossips(#{@author.gossips.count})", response.body
		assert_select "div.digg_pagination"
		@author.gossips.paginate(page: 1).each do |gossip|
			assert_match gossip.body, response.body
		end
		# Following/Follower stats
		assert_select "a[href=?]", following_author_path(@author)
		assert_select "a[href=?]", followers_author_path(@author)
		assert_select "#following", text: "#{@author.following.count}"
		assert_select "#followers", text: "#{@author.followers.count}"
	end
end
