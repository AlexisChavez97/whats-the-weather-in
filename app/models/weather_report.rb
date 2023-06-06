# frozen_string_literal: true

# frozen_string_literal_true

class WeatherReport < ApplicationRecord
  belongs_to :user

  validates_presence_of :city, :condition, :temperature, :latitude, :longitude, :icon

  scope :recent, -> { order(created_at: :desc).limit(5) }
end
