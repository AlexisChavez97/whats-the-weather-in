# frozen_string_literal: true

class WeatherForecast < ApplicationRecord
  belongs_to :weather_report
  has_many :daily_weather_forecasts, dependent: :destroy
end
