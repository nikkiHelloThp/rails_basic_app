require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

	def setup
		@author = authors(:one)
		log_in_as(@author)
	end

	test "following page" do
		get following_author_path(@author)
		assert_not @author.following.empty?
		assert_match @author.following.count.to_s, response.body
		@author.following.each do |author|
			assert_select "a[href=?]", author_path(author)
		end
	end

	test "followers page" do
		get followers_author_path(@author)
		assert_not @author.followers.empty?
		assert_match @author.followers.count.to_s, response.body
		@author.followers.each do |author|
			assert_select "a[href=?]", author_path(author)
		end
	end
end
