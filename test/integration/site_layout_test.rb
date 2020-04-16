require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
  	get gossips_path
  	assert_select "a[href=?]", root_path, count: 2
  	assert_select "a[href=?]", team_path
  	assert_select "a[href=?]", contact_path
  	assert_select "a[href=?]", new_session_path
  end

	test "the team page" do
  	get "/team"
  	assert_select 'h1', "The team 😉"
	end
end
