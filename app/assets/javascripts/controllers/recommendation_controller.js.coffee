WindowAndFan.recommendationController = Ember.Controller.create

  rootUrl:"http://young-tor-7683.herokuapp.com/"
  states:['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
  high_temperatures:[65..85]
  low_temperatures:[50..70]

  selectedState:"OH"
  selectedCity:"Columbus"
  selectedLow:62
  selectedHigh:78

  reccomendation:"Pick Some Values"

  calculateFirstRecommendation:(()->
    $.get(this.get('rootUrl')+"weather/hourly.json?city="+this.get('selectedCity')+"&state="+this.get('selectedState'), (response) ->
      started = false
      finished = false
      if response.weather!=undefined
        for hour in response.weather
          in_window = (hour.temperature>=WindowAndFan.recommendationController.get('selectedLow') && hour.temperature<=WindowAndFan.recommendationController.get('selectedHigh'))
          if(in_window && !started)
            started=hour.time
          if(started!=false && !finished && !in_window)
            finished=hour.time
        #Was found to be in the window at least once
        if(started!=false)
          reccomendation_string = "You should open your windows and turn on your fans starting at "+started+" and turn them off at "
          if(finished!=false)
            #And droped out of the window
            reccomendation_string += finished+"."
          else
            reccomendation_string += " maybe tomorrow."

        else
          reccomendation_string = """Whatever you do, don't open your windows. 
          The weather stinks (And there might be zombies).
          """
      else
        reccomendation_string = "Invalid City/State Combo"
      WindowAndFan.recommendationController.set('reccomendation', reccomendation_string)
    )
  ).observes("selectedState", "selectedCity", "selectedLow", "selectedHigh")

















































