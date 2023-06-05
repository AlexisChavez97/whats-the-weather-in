# frozen_string_literal: true

module OpenWeather
  class Client
    BASE_URL = "https://api.openweathermap.org"

    def get(resource:, **params)
      OpenWeather::Resources.const_get(resource.classify).new(self).get(params)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |connection|
        connection.headers["x-api-key"] = ENV["OPEN_WEATHER_API_KEY"]

        connection.response :json, content_type: "application/json"
      end
    end
  end
end
