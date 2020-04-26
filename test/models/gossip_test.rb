require 'test_helper'

class GossipTest < ActiveSupport::TestCase

  def setup
    @author = authors(:one)
    @gossip = @author.gossips.build(body: "Lorem ispum")
  end

  test "should be valid" do
    assert @gossip.valid?
  end

  test "user id should be present" do
    @gossip.author_id = nil
    assert_not @gossip.valid?
  end

  test "body should be present" do
    @gossip.body = " " * 5
    assert_not @gossip.valid?
  end

  test "body should be 140 characters maximum" do
    @gossip.body = "a" * 141
    assert_not @gossip.valid?
  end

  test "gossip should appear in descending order" do
    assert_equal Gossip.first, gossips(:most_recent)
  end


	# test "should not save an invalid new gossip" do
 #  	gossip = Author.new.gossips.build(
 #               title: 'My',
 #               body: 'Title not long enough'
 #             )
 #    assert_not gossip.save
 #  end

 #  test "should not save a new gossip without author" do
 #  	gossip = Gossip.new(title: 'My title', body: 'My body')
 #    assert_not gossip.save
 #  end

 #  test "should save a valid new gossip" do
 #  	gossip = Author.new.gossips.build(
 #               title: 'My title',
 #               body: 'Title long enough'
 #             )
 #    assert gossip.save
 #  end
end
