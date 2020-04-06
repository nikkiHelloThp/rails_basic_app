require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  test "should get show" do
    get(:show, params: {id: City.last.id})
    assert_response :success
  end

end
