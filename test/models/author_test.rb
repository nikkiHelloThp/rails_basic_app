require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "should not save author without parameters" do
    author = Author.new
    assert_not author.save
  end

  test "should save a valid author" do
		author = Author.new(email: 'mail@mail.com', password: '000000')
		assert author.save
	end
end
