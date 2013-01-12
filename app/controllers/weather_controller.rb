require 'open-uri'

class WeatherController < ApplicationController
  include HTTParty
  include WeatherHelper

  def hourly
    response_object = {}
    begin
      state = URI::encode(""+params[:state].to_s)
      city = URI::encode(""+params[:city].to_s)

      html = self.class.get("http://www.findlocalweather.com/hourly/#{state}/#{city}.html")
      status = html.code
      case html.code
        when 200
          response_object = self.parseWeatherHTML html
        when 403..404
          response_object = {'error' => 'City and state combination not found, or missing.'}
        else
          status = 500
          response_object = {'error' => 'Error getting weather data, try again later.'}
      end
    rescue Exception => e
      response_object = {'error' => "Error getting weather data, try again later."}
      puts e.backtrace
      status = 500
    end
    
    respond_to do |format|
      format.html { render :json => response_object, :status => status }
      format.json { render :json => response_object, :status => status}
      format.xml  { render :xml => response_object, :status => status  }
    end
  end
end
