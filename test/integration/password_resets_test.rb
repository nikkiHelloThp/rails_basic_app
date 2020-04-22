require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
	def setup
		ActionMailer::Base.deliveries.clear
		@author = authors(:one)
	end

	test "password reset" do
		get new_password_reset_path
		assert_template 'password_resets/new'
		# Invalid email
		post password_resets_path, params: {
																 password_reset: {
																 	 email: ""
																 }
															 }
		assert_not flash.empty?
		assert_template 'password_resets/new'
		# Valid email
		post password_resets_path, params: {
																 password_reset: {
																 	 email: @author.email
																 }
															 }
		assert_not_equal @author.reset_digest, @author.reload.reset_digest
		assert_equal 1, ActionMailer::Base.deliveries.size
		assert_not flash.empty?
		assert_redirected_to root_url
		# Password reset form
		author = assigns(:author)
		# Wrong email
		get edit_password_reset_path(author.reset_token, email: "")
		assert_redirected_to root_url
		# Inactive user
		author.toggle!(:activated)
		get edit_password_reset_path(author.reset_token, email: author.email)
		assert_redirected_to root_url
		author.toggle!(:activated)
		# Right email, wrong token
		get edit_password_reset_path("wrong", email: author.email)
		assert_redirected_to root_url
		# Right email, right token
		get edit_password_reset_path(author.reset_token, email: author.email)
		assert_template 'password_resets/edit'
		assert_select "input[name=email][type=hidden][value=?]", author.email
		# Invalid password & confirmation
		patch password_reset_path(author.reset_token),
					params: {
						email: author.email,
						author: {
							password: 						 "foobar",
							password_confirmation: "barbaz"
						}
					}
		assert_select "div#error_explanation"
		# Blank password & confirmation
		patch password_reset_path(author.reset_token),
					params: {
						email: author.email,
						author: { password: "", password_confirmation: "foobar" }
					}	
		assert_not flash.empty?
		assert_template 'password_resets/edit'
		# Valid password & confirmation
		patch password_reset_path(author.reset_token),
					params: {
						email: author.email,
						author: {
							password: 						 "foobar",
							password_confirmation: "foobar"
						}
					}
		assert is_logged_in?
		assert_not flash.empty?
		assert_redirected_to author
	end

	test "expired token" do
		get new_password_reset_path
		post password_resets_path, params: {
																 password_reset: {
																 	 email: @author.email
																 }
															 }
		@author = assigns(:author)
		@author.update_attribute(:reset_sent_at, 3.hours.ago)
		patch password_reset_path(@author.reset_token),
					params: {
						email: @author.email,
						author: {
							password: 						 "foobar",
							password_confirmation: "foobar"
						}
					}
		assert_response :redirect
		follow_redirect!
		assert_match /expired/i, response.body
	end
end
