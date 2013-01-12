Window and Fan
======

Have you ever been inside and it is cool outside and you open the windows and put a fan in the window to ventilate your house/apartment?

Well, "Window and Fan" is a tool that will help you know "when" you should turn on and off your fan for maximum benifit!

Application
------

To use the application, type in your city and state and choose your comfort zone.  The app will tell you when to "open your windows and turn on your fans"

#### Deployment

This is deployed to [heroku](http://young-tor-7683.herokuapp.com/).

Weather Scraper
------

There is a weather scraper built into this app it will give you the hourly forcast given a city and state

#### Usage:

Do a GET request at 

    http://(root)/weather/hourly.(format)

Where:

    root - the heroku or development root: i.e. "0.0.0.0:3000".  
    format - "json", "xml", or "html"

Include the request params:

    city - the city of interest, i.e. "columbus"
    state - two letter code for the state, i.e. "oh"

Examples:

    http://young-tor-7683.herokuapp.com/weather/hourly.json?city=columbus&state=oh
    http://young-tor-7683.herokuapp.com/weather/hourly.xml?city=chicago&state=il


