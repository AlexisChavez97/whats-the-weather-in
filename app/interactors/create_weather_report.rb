# frozen_string_literal: true

class CreateWeatherReport
  include Interactor::Organizer

  organize FetchGeolocation, FetchWeatherData, CreateCurrentWeather, CreateWeatherForecast
end
