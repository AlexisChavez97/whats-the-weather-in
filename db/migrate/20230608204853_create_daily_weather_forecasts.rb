# frozen_string_literal: true

class CreateDailyWeatherForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_weather_forecasts do |t|
      t.date :date
      t.string :summary
      t.string :high
      t.string :low
      t.string :icon
      t.belongs_to :weather_report, index: true, foreign_key: true

      t.timestamps
    end
  end
end
