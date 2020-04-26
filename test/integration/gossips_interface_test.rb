require 'test_helper'

class GossipsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
  	@author = authors(:one)
  end
  test "gossip interface" do
  	log_in_as(@author)
  	get root_path
  	assert_select "div.digg_pagination"
  	# Invalid submission
  	assert_no_difference "Gossip.count" do
  		post gossips_path, params: { gossip: { body: "" } }
  	end
  	assert_template 'static_pages/home'
  	assert_select "div#error_explanation"
  	# Valid submission
  	body = "Lorem ipsum dolor sit amet"
  	assert_difference "Gossip.count", 1 do
  		post gossips_path, params: { gossip: { body: body } }
  	end
  	assert_not flash.empty?
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_match body, response.body
  	# Delete gossip
  	assert_select "a", text: "delete"
  	first_gossip = @author.gossips.paginate(page: 1).first
  	assert_difference "Gossip.count", -1 do
  		delete gossip_path(first_gossip)
  	end
  	# Visit a different profile
  	get author_path(authors(:two))
  	assert_select "a", text: "delete", count: 0
  end
end
