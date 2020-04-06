require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, params: {id: Author.last.id}
    assert_response :success
  end

end
