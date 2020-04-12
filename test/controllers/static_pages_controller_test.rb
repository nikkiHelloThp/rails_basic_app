require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @base_title = "| TheGossipProject"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home #{@base_title}"
  end
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact #{@base_title}"
  end

  test "should get team" do
    get :team
    assert_response :success
    assert_select "title", "Team #{@base_title}"
  end

  test "should get welcome" do
    get :welcome, params: {name: 'a name'}
    assert_response :success
    assert_select "title", "Welcome #{@base_title}"
    assert_select "h1", "Welcome a name"
  end
end
