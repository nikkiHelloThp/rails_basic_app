require 'test_helper'

class AuthorsEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = authors(:one)
	end

  test "when invalid update information" do
    log_in_as(@user, {remember_me: '0'}) # must be logged in to access edit
    get edit_author_path(@user)
    assert_template 'authors/edit'
    patch author_path(@user), params: { author: { name: '',
      																						email: '',
      																						password: '',
      																						password_confirmation: ''
    																						}
    																	}
  	assert_template 'authors/edit'
  	assert_select "div#error_explanation" do
  		assert_select "p", "The form contains 5 errors"
  		assert_select "ul" do
  			assert_select "li[1]", "Name can't be blank"
  			assert_select "li[2]", "Name is too short (minimum is 6 characters)"
  			assert_select "li[3]", "Name is invalid"
  			assert_select "li[4]", "Email can't be blank"
  			assert_select "li[5]", "Email is invalid"
  		end
  	end
  end

  test "when valid update information with friendly forwarding" do
    get edit_author_path(@user)
    log_in_as(@user, {remember_me: '0'})
    assert_redirected_to edit_author_path(@user)
    name = 'Alex kid'
    email = 'alexkid@example.com'
    patch author_path(@user), params: { author: { name:  name,
      																						email: email,
      																						password: '',
      																						password_confirmation: ''
    																						}
    																	}
    assert_redirected_to @user # == follow_redirect! + assert_template 'authors/show'
    assert_not flash.empty?
    @user.reload
    assert_equal @user.name,  name
    assert_equal @user.email, email
  end
end
