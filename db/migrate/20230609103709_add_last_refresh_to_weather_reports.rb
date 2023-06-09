# frozen_string_literal: true

class AddLastRefreshToWeatherReports < ActiveRecord::Migration[7.0]
  def change
    add_column :weather_reports, :last_refresh, :datetime
  end
end
