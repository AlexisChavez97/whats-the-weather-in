# frozen_string_literal: true

class UpdateWeatherForecast
  include Interactor

  def call
    destroy_old_forecast
    update_weather_forecast
  end

  private
    def update_weather_forecast
      forecast.build(daily_weather_forecasts)
      context.fail!(message: forecast.errors.full_messages) unless context.weather_report.save
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

    def destroy_old_forecast
      forecast.destroy_all
    end

    def forecast
      context.weather_report.forecast
    end
end
