require 'open-uri'

class WeatherController < ApplicationController
  include HTTParty
  include WeatherHelper

  def hourly
    response_object = nil
    weather = nil
    status = nil
    begin
      #check to see if we have a valid model saved
      if params[:state] && params[:city]
        weather = Weather.where("city = ? AND state = ?", params[:city], params[:state])
        if weather.any? && weather[0].valid?
          #If found and valid set it to be returned.
          puts "found"
          weather = weather[0]
        else
          #if not the save and return a new object
          state = URI::encode(""+params[:state].to_s)
          city = URI::encode(""+params[:city].to_s)
          html = self.class.get("http://www.findlocalweather.com/hourly/#{state}/#{city}.html")
          status = html.code
          case html.code
            when 200
              #Create and cache
              puts "create and save"
              weather_data = self.parseWeatherHTML html
              weather = Weather.new(:city=>params[:city], :state=>params[:state], :time_cached=>Time.now.to_f, :weather_data=>weather_data.to_json)
              weather.save()
            when 403..404
              response_object = {'error' => 'City and state combination not found, or missing.'}
            else
              puts "500"
              status = 500
              response_object = {'error' => 'Error getting weather data, try again later.'}
          end
        end
      else
        puts "404"
        status = 404
        response_object = {'error' => 'City and state combination not found, or missing.'}
      end
    rescue Exception => e
      puts "Exception"
      response_object = {'error' => "Error getting weather data, try again later."}
      status = 500
    end
    if(!weather.nil? && !weather.errors.any?)
      response_object = ActiveSupport::JSON.decode(weather.weather_data)
    end
    respond_to do |format|
      format.json { render :json => response_object, :status => status}
      format.xml  { render :xml => response_object, :status => status  }
    end
  end
end
