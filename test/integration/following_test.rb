require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

	def setup
		@author = authors(:one)
		@other  = authors(:test_40)
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

	test "should follow an author" do
		assert_difference "@author.following.count", 1 do
			post relationships_path, params: { followed_id: @other.id }
		end
	end

	test "should follow an author with Ajax" do
		assert_difference "@author.following.count", 1 do
			post relationships_path, xhr: true, params: { followed_id: @other.id }
		end
	end

	test "should unfollow an author" do
		@author.follow(@other)
		relationship = @author.active_relationships.find_by(followed_id: @other.id)
		assert_difference "@author.following.count", -1 do
			delete relationship_path(relationship)
		end
	end

	test "should unfollow an author with Ajax" do
		@author.follow(@other)
		relationship = @author.active_relationships.find_by(followed_id: @other.id)
		assert_difference "@author.following.count", -1 do
			delete relationship_path(relationship), xhr: true
		end
	end
end
