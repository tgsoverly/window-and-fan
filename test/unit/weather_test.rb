require 'test_helper'

class WeatherTest < ActiveSupport::TestCase
  test "blank weather" do
    weather = Weather.new
  	assert !weather.save, "Could not save without values"
  end

  test "not expired weather" do
    weather = Weather.new(:city=>'columbus', :state=> 'oh', :weather_data=>"{some:object}", :time_cached=>(Time.now-100).to_f)
    assert weather.save, "Could save with values"
  end

  test "expired weather" do
    weather = Weather.new(:city=>'columbus', :state=> 'oh', :weather_data=>"{some:object}", :time_cached=>(Time.now-3601).to_f)
  	assert !weather.save, "Could not save with expired time"
  end
end
