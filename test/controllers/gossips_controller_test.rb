require 'test_helper'

class GossipsControllerTest < ActionController::TestCase
  test "should get index" do
  	get :index
    assert_response :success
  end
  
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
