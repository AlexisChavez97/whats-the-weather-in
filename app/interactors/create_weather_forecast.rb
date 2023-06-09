# frozen_string_literal: true

class CreateWeatherForecast
  include Interactor

  def call
    save_weather_forecast
  end

  private
    def save_weather_forecast
      context.weather_report.forecast.build(daily_weather_forecasts)
      context.fail!(message: context.weather_report.errors.full_messages) unless context.weather_report.save
    end

    def daily_weather_forecasts
      context.weather_data.daily.map do |daily_weather|
        daily_weather_forecast_attributes(daily_weather)
      end
    end

    def daily_weather_forecast_attributes(daily_weather)
      {
        date: Time.at(daily_weather.dt).to_date,
        high: daily_weather.temp.max,
        low: daily_weather.temp.min,
        icon: daily_weather.weather.first.icon,
        summary: daily_weather.summary
      }
    end
end
