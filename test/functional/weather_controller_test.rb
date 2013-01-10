require 'test_helper'

class WeatherControllerTest < ActionController::TestCase
  test "should get hourly" do
    get :hourly
    assert_response :success
  end

end
