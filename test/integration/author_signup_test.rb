require 'test_helper'

class AuthorSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    # clear needed, .size not reset for each test
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup informations" do
    get new_author_path
    assert_no_difference "Author.count" do
	    post authors_path, params: {
                           author: {
                             name:       'Walter Sobchak',
                             email: 		 'author@invalid',
	    											 password: 							'foo',
	    						 					 password_confirmation: 'bar',
	    										 }
	    									 }
		end
    assert_template 'authors/new'
    assert_select "div#error_explanation" do
      assert_select "p", "The form contains 3 errors"
      assert_select "ul" do
        assert_select "li[1]", "Password confirmation doesn't match Password"
        assert_select "li[2]", "Email is invalid"
        assert_select "li[3]", "Password is too short (minimum is 6 characters)"
      end
    end
  end

  test "valid signup informations" do
  	get new_author_path
  	assert_difference "Author.count", 1 do
  		post authors_path, params: {
                           author: {
                             name:        'Duke Lebowski',
                             email: 			'author@valid.com',
                          	 password: 							'foobar',
  													 password_confirmation: 'foobar',
  												 }
  											 }
  	end
  	assert_equal 1, ActionMailer::Base.deliveries.size
    author = assigns(:author)
    assert_not author.activated?
    # try to log in before activation
    log_in_as(author)
    assert_not is_logged_in?
    # Index page
    # Log in as a valid user
    log_in_as(authors(:one))
    # Unactivated user is on the second page but should not appear
    get authors_path, params: { page: 2 }
    assert_no_match author.name, response.body
    # Profile page unactivated user
    get author_path(author)
    assert_redirected_to root_url
    # Log out valid user
    delete session_path(author)
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # invalid activation email
    get edit_account_activation_path(author.activation_token, email: "wrong@email")
    assert_not is_logged_in?
    # valid activation email-token
    get edit_account_activation_path(author.activation_token, email: author.email)
    assert author.reload.activated?
    follow_redirect!
  	assert_template 'authors/show'
    assert is_logged_in?
    assert_not flash.empty?
  end
end
