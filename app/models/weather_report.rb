# frozen_string_literal: true

class WeatherReport < ApplicationRecord
  belongs_to :user

  has_many :daily_weather_forecasts, dependent: :destroy

  validates_presence_of :city, :state, :condition, :temperature, :latitude, :longitude, :icon

  scope :recent, -> { order(created_at: :desc).limit(11) }

  def forecast
    daily_weather_forecasts
  end

  def temperature_to_degrees
    "#{temperature}°"
  end

  def updated_or_created
    if updated_at != created_at
      Time.current - updated_at
    else
      Time.current - created_at
    end
  end

  # rubocop:disable Performance/OpenStruct
  def geolocation
    OpenStruct.new(lat: latitude, lon: longitude)
  end

  def time_ago
    time_difference = updated_or_created
    seconds = time_difference.to_i

    case
    when seconds < 1.minute
      "just now"
    when seconds < 1.hour
      "#{seconds / 1.minute} minutes ago"
    when seconds < 1.day
      "#{seconds / 1.hour} hours ago"
    when seconds < 1.month
      "#{seconds / 1.day} days ago"
    when seconds < 1.year
      "#{seconds / 1.month} months ago"
    else
      "#{seconds / 1.year} years ago"
    end
  end
end
