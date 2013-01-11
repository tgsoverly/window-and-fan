require 'test_helper'

class WeatherControllerTest < ActionController::TestCase
  test "should not get hourly without params" do
    get :hourly
    assert_response 403
  end

  test "should get hourly with params" do
    get :hourly, {:params => {:state => 'oh', :city => 'columbus'}}
    assert_response 403
  end
end
