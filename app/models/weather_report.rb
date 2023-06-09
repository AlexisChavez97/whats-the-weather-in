# frozen_string_literal: true

class WeatherReport < ApplicationRecord
  belongs_to :user

  before_save :update_last_refresh

  has_many :daily_weather_forecasts, dependent: :destroy

  validates_presence_of :city, :state, :condition, :temperature, :latitude, :longitude, :icon

  scope :recent, -> { order(created_at: :desc).limit(11) }

  def forecast
    daily_weather_forecasts
  end

  def temperature_to_degrees
    "#{temperature}°"
  end

  # rubocop:disable Performance/OpenStruct
  def geolocation
    OpenStruct.new(lat: latitude, lon: longitude)
  end

  def time_ago
    time_difference = Time.current - last_refresh
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

  private
    def update_last_refresh
      self.last_refresh = Time.current
    end
end
