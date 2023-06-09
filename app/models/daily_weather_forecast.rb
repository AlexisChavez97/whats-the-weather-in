# frozen_string_literal: true

class DailyWeatherForecast < ApplicationRecord
  belongs_to :weather_forecast

  validates_presence_of :date, :high, :low, :icon, :summary

  def humanized_date
    date.strftime("%b %e")
  end

  def temperature_range
    "H:#{high}°" " L:#{low}°"
  end
end
