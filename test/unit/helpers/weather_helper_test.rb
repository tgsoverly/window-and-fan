require 'test_helper'

class WeatherHelperTest < ActionView::TestCase
  include WeatherHelper

  test "helper should parse valid html" do
    html = File.read("test/fixtures/html/chicago.html")
    response_object = self.parseWeatherHTML html
    assert_equal 24, response_object.size(), "Valid weather not returned."  
  end

  test "helper should return error for invalid html" do
    html = File.read("test/fixtures/html/404.html")
    response_object = self.parseWeatherHTML html
    assert_equal 1, response_object.size(), "Error object not returned."  
  end

end
