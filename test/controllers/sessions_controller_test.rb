require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    # post :create
    # assert_response :success
  end

  # test "should get destroy" do
  #   delete :destroy, params: {session: {user_id: Author.last.id}}
  #   assert_response :success
  # end

end
