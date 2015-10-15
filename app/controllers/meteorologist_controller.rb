require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    latitude2 = latitude.to_s
    longitude2 = longitude.to_s

    urlForecast = "https://api.forecast.io/forecast/fbad6bb599e98262981ded62ea22e011/"+latitude2+","+longitude2

    parsed_data2 = JSON.parse(open(urlForecast).read)
    temperature = parsed_data2["currently"]["temperature"]
    currentSummary = parsed_data2["currently"]["summary"]
    nextSixtyMinutes = parsed_data2["minutely"]["summary"]
    nextSeveralHours = parsed_data2["hourly"]["summary"]
    nextSeveralDays = parsed_data2["daily"]["summary"]




    @current_temperature = temperature

    @current_summary = currentSummary

    @summary_of_next_sixty_minutes = nextSixtyMinutes

    @summary_of_next_several_hours = nextSeveralHours

    @summary_of_next_several_days = nextSeveralDays

    render("street_to_weather.html.erb")
  end
end
