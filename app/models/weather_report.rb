# frozen_string_literal: true

# frozen_string_literal_true

class WeatherReport < ApplicationRecord
  belongs_to :user

  validates_presence_of :city, :condition, :temperature, :latitude, :longitude, :icon

  scope :recent, -> { order(created_at: :desc).limit(11) }

  def temperature_to_degrees
    "#{temperature}°"
  end

  def time_ago
    time_difference = Time.current - created_at
    seconds = time_difference.to_i

    if seconds < 1.minute
      "just now"
    elsif seconds < 1.hour
      "#{seconds / 1.minute} minutes ago"
    elsif seconds < 1.day
      "#{seconds / 1.hour} hours ago"
    elsif seconds < 1.month
      "#{seconds / 1.day} days ago"
    elsif seconds < 1.year
      "#{seconds / 1.month} months ago"
    else
      "#{seconds / 1.year} years ago"
    end
  end
end
