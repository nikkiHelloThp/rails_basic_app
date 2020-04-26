require 'test_helper'

class GossipsControllerTest < ActionController::TestCase
  def setup
    @gossip = gossips(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Gossip.count" do
      post :create, params: {
                      gossip:{
                        body: "Lorem ipsum",
                        author: @gossip,
                      }
                    }
    end
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Gossip.count" do
      delete :destroy, params: { id: @gossip }
    end
    assert_redirected_to new_session_url
  end

  test "should redirect destroy for wrong gossip" do
    log_in_as(authors(:one))
    assert_no_difference "Gossip.count" do
      delete :destroy, params: { id: gossips(:fourty_one) }
    end
  end
  # test "should get index" do
  # 	get :index
  #   assert_response :success
  # end
  
  # test "should get show" do
  # 	get :show, params: {id: Gossip.last.id}
  #   assert_response :success
  # end
  
  # test "should get new" do
  # 	get :new
  #   assert_response :success
  # end
  
  # test "should get create" do
  # 	get :create
  #   assert_response :success
  # end
  
  # test "should get edit" do
  # 	get :edit
  #   assert_response :success
  # end
  
  # test "should get update" do
  # 	get :update
  #   assert_response :success
  # end
  
  # test "should get destroy" do
  # 	get :destroy
  #   assert_response :success
  # end
end
