require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
	
	def setup
		@relationship = Relationship.new(follower_id: authors(:one).id,
																		 followed_id: authors(:two).id)
	end

	test "should be valid" do
		assert @relationship.valid?
	end

	test "should require a follower_id" do
		@relationship.follower_id = nil
		assert_not @relationship.valid?
	end

	test "should require a followed_id" do
		@relationship.followed_id = nil
		assert_not @relationship.valid?
	end

	test "should follow and unfollow an author" do
		first  = authors(:test_11)
		second = authors(:test_12)
		assert_not first.following?(second)
		first.follow(second)
		assert first.following?(second)
		assert second.followers.include?(first)
		first.unfollow(second)
	assert_not first.following?(second)
	end
end
