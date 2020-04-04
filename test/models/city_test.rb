require 'test_helper'

class CityTest < ActiveSupport::TestCase
  test "should save city" do
  	city = City.new
    assert city.save
  end
end
