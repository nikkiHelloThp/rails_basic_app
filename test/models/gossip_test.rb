require 'test_helper'

class GossipTest < ActiveSupport::TestCase
	test "should not save an invalid new gossip" do
  	gossip = Author.new.gossips.build(title: 'My', body: 'Title not long enough')
    assert_not gossip.save
  end

  test "should not save a new gossip without author" do
  	gossip = Gossip.new(title: 'My title', body: 'My body')
    assert_not gossip.save
  end

  test "should save a valid new gossip" do
  	gossip = Author.new.gossips.build(title: 'My title', body: 'Title long enough')
    assert gossip.save
  end
end
