require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.forecast.io/forecast/fbad6bb599e98262981ded62ea22e011/"+@lat+","+@lng

    parsed_data = JSON.parse(open(url).read)
    temperature = parsed_data["currently"]["temperature"]
    currentSummary = parsed_data["currently"]["summary"]
    nextSixtyMinutes = parsed_data["minutely"]["summary"]
    nextSeveralHours = parsed_data["hourly"]["summary"]
    nextSeveralDays = parsed_data["daily"]["summary"]

    @current_temperature = temperature

    @current_summary = currentSummary

    @summary_of_next_sixty_minutes = nextSixtyMinutes

    @summary_of_next_several_hours = nextSeveralHours

    @summary_of_next_several_days = nextSeveralDays

    render("coords_to_weather.html.erb")
  end
end
