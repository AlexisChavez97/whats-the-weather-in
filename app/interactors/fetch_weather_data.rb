# frozen_string_literal: true

class FetchWeatherData
  include Interactor

  def call
    context.weather_data = fetch_weather_data

  rescue StandardError => e
    context.fail!(message: e.message)
  end

  private
    def fetch_weather_data
      context.client.get(resource: "one_call", lat: context.geolocation.lat, lon: context.geolocation.lon)
    end
end
