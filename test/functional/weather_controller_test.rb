require 'test_helper'

class WeatherControllerTest < ActionController::TestCase
  test "should not get html" do
    get :hourly
    assert_response 406
  end

  test "should not get hourly without params" do
    get :hourly, :format => :json
    assert_response 404
  end

  test "should get hourly with params" do
    get :hourly, {:state => 'oh', :city => 'columbus', :format => :json}
    assert_response 200
  end
end
