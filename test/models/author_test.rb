require 'test_helper'
 
class AuthorTest < ActiveSupport::TestCase

	def setup
		@author = Author.new(email: 'email@mail.com', password: '000000')
	end

	test "should be valid" do
		assert @author.valid?
	end

	test "email should be present" do
		@author.email = '   '
		assert_not @author.valid?
		assert_equal @author.errors.full_messages[0], "Email can't be blank"
	end

	test "email should be 255 characters maximum" do
		@author.email = 'a' * 244 + "@example.com"
		assert_not @author.valid?
	end

	test "email should accept valid addresses" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-er@foo.bar.org
												 first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@author.email = valid_address
			assert @author.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
													 foo@bar_baz.com foo@bar+baz.com foo@bar..com]
		invalid_addresses.each do |invalid_address|
			@author.email = invalid_address
			assert_not @author.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	test "email address should be unique" do
		duplicate_author = @author.dup
		@author.email = @author.email.upcase
		@author.save
		assert_not duplicate_author.valid?
		assert_equal duplicate_author.errors.full_messages[0], "Email has already been taken"
	end

	test "email should be downcased before save" do
		mixed_case_email = 'EmAiL@mAiL.CoM'
		@author.email = mixed_case_email
		@author.save
		assert_equal mixed_case_email.downcase, @author.reload.email
	end

	test "password should be present" do
		@author.password = '   '
		assert_not @author.valid?
		assert_equal @author.errors.full_messages[0], "Password can't be blank"
	end

	test "password should be 6 characters minimum" do
		@author.password = 'a' * 5
		assert_not @author.valid?
		assert_equal @author.errors.full_messages[0], "Password is too short (minimum is 6 characters)"
	end
end
