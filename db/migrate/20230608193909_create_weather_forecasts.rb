# frozen_string_literal: true

class CreateWeatherForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_forecasts do |t|
      t.belongs_to :weather_report, index: true, foreign_key: true

      t.timestamps
    end
  end
end
