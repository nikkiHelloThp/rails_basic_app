require 'test_helper'

class GossipsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
  	@author = authors(:one)
  end

  test "gossip interface" do
  	log_in_as(@author)
  	get root_path
  	assert_select "div.digg_pagination"
    assert_select "input[type=file]"
  	# Invalid submission
  	assert_no_difference "Gossip.count" do
  		post gossips_path, params: { gossip: { body: "" } }
  	end
  	assert_template 'static_pages/home'
  	assert_select "div#error_explanation"
  	# Valid submission
  	body    = "Lorem ipsum dolor sit amet"
    picture = fixture_file_upload('test/fixtures/picture_sample.jpg', 'image/jpeg')
  	assert_difference "Gossip.count", 1 do
  		post gossips_path, params: {
                           gossip: {
                             body: body,
                             picture: picture,
                           }
                         }
  	end
    assert assigns(:gossip).picture.attached?
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

  test "Sidebar count" do
    log_in_as(@author)
    get root_path
    assert_match "#{@author.gossips.count} gossips", response.body
    # Author with no gossip
    other_author = authors(:test_3)
    log_in_as(other_author)
    get root_path
    assert_no_match "#{@author.gossips.count} gossips", response.body
    other_author.gossips.create!(body: "Lorem ipsum dolor sit amet.")
    get root_path
    assert_match "#{other_author.gossips.count} gossip", response.body
  end
end
