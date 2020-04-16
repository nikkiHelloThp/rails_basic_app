require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links when not logged in" do
  	get gossips_path
  	assert_select "a[href=?]", root_path, count: 2
  	assert_select "a[href=?]", team_path
  	assert_select "a[href=?]", contact_path
  	assert_select "a[href=?]", new_session_path
  end

  test "layout links when logged in" do
    author = authors(:one)
    log_in_as(author)
    get gossips_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", new_gossip_path
    assert_select "a[href=?]", authors_path
    assert_select "a[href=?]", conversations_path
    assert_select "a[href=?]", author_path(author)
    assert_select "a[href=?]", edit_author_path(author)
    assert_select "a[href=?]", author_path(author), method: :delete
    assert_select "a[href=?]", team_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", new_session_path, false
  end

	test "the team page" do
  	get "/team"
  	assert_select 'h1', "The team 😉"
	end
end
