require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase

  test "should redirect create when not logged in" do
    assert_no_difference "Relationship.count" do
    	post :create
    end
    assert_redirected_to new_session_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Relationship.count" do
    	delete :destroy, params: { id: relationships(:one) }
    end
    assert_redirected_to new_session_url
  end
end