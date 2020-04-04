require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "should save a tag" do
  	tag = Tag.new
    assert tag.save
  end
end
