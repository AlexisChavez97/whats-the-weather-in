# frozen_string_literal: true

class UpdateWeatherReport
  include Interactor::Organizer

  organize FetchWeatherData, UpdateCurrentWeather, UpdateWeatherForecast
end
