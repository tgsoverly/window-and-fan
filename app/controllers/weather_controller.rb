require 'open-uri'

class WeatherController < ApplicationController
  include HTTParty
  include WeatherHelper

  def hourly
    html = self.class.get("http://www.findlocalweather.com/hourly/#{params[:state]}/#{params[:city]}.html")
    case html.code
      when 200
        json_weather_map = self.parseWeatherHTML html
        render json: json_weather_map.to_json
      when 404
        render json: {'error' => 'City and state combination not found.'}
      when 500...600
        render json: {'error' => 'Error getting weather data, try again later.'}
    end
  end
end
