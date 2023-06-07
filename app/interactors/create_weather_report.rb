# frozen_string_literal: true

class CreateWeatherReport
  include Interactor

  def call
    weather_report = WeatherReport.new(weather_report_attributes)
    weather_report.user = context.user
    if weather_report.save
      context.weather_report = weather_report
    else
      context.fail!(message: weather_report.errors.full_messages)
    end
  rescue StandardError => e
    context.fail!(message: e.message)
  end

  private
    def geolocation
      @geolocation ||= context.client.get(resource: "geolocation", q: context.params[:city])
    end

    def weather_data
      @weather_data ||= context.client.get(resource: "current_weather", lat: geolocation.lat, lon: geolocation.lon)
    end

    def weather_report_attributes
      {
        city: geolocation.name,
        condition: weather_data.weather.first.description,
        temperature: weather_data.main.temp,
        latitude: geolocation.lat,
        longitude: geolocation.lon,
        icon: weather_data.weather.first.icon
      }
    end
end
