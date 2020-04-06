require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should save a new comment" do
    comment = Comment.new(author: Author.last, commentable_id: Gossip.last.id, commentable_type: 'Gossip', body: 'this is a comment')
    assert comment.save
  end
end
