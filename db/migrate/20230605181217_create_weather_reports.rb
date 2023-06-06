# frozen_string_literal: true

class CreateWeatherReports < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_reports do |t|
      t.string :city
      t.string :condition
      t.string :temperature
      t.string :latitude
      t.string :longitude
      t.string :icon
      t.belongs_to :user, index: true, foreign_key: true

      t.index :city
      t.timestamps
    end
  end
end
