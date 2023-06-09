# frozen_string_literal: true

class UpdateCurrentWeather
  include Interactor

  def call
    update_weather_report
  end

  private
    def update_weather_report
      context.fail!(message: context.weather_report.errors.full_messages) unless context.weather_report.update(weather_report_attributes)
    end

    def weather_report_attributes
      {
        condition: context.weather_data.current.weather.first.description,
        temperature: context.weather_data.current.temp,
        icon: context.weather_data.current.weather.first.icon
      }
    end
end
