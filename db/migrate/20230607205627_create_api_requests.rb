# frozen_string_literal: true

class CreateApiRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :api_requests do |t|
      t.text :url, null: false
      t.json :response_data
      t.timestamps
    end

    add_index :api_requests, :url, unique: true
  end
end
