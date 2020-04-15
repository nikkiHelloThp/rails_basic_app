require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = authors(:one)
	end

  test "login with invalid information" do
    get new_session_path
    assert_template 'sessions/new'
    post sessions_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by log out" do
  	get new_session_path
  	assert_template 'sessions/new'
  	post sessions_path, params: { session: { email: @user.email, password: '123456'}}
    assert is_logged_in?
  	assert_redirected_to author_path(@user)
  	follow_redirect!
  	assert_template 'authors/show'
  	assert_select "a[href=?]", new_session_path, count: 0
    assert_select "a[href=?]", author_path(@user)
  	assert_select "a[href=?]", session_path(@user)
    delete session_path(@user)
    assert_not is_logged_in?
    assert_redirected_to root_path
    # simulate a user clicking log out in a second window.
    delete session_path(@user)
    follow_redirect!
    assert_template '/'
    assert_select "a[href=?]", new_session_path
    assert_select "a[href=?]", author_path(@user), count: 0
    assert_select "a[href=?]", session_path(@user), count: 0
  end

  test "login with remember me" do
    log_in_as(@user, remember_me: '1')
    assert_equal assigns(:user).remember_token, cookies[:remember_token] 
  end

  test "login without remember me" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies[:remember_token]
  end
end
