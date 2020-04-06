require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "should save a new like" do
  	like = Like.new(author: Author.last, gossip: Gossip.last)
    assert like.save 
  end
end
