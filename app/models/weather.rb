class Weather < ActiveRecord::Base
  
  attr_accessible :city, :state, :time_cached, :weather_data

  validates :city, :state, :weather_data, :presence => true
  validate :valid_cache
  
  def valid_cache
    #expire if over 1 hour old
    if time_cached.nil?
        errors.add(:time_cached, 'time cached can not be nil')
    else
  	  if (Time.now - Time.at(time_cached))>3600.0
        errors.add(:time_cached, 'the time cached is more than 1 hour ago')
      end
    end
  end
end
