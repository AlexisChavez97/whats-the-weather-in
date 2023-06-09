# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_09_103709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", force: :cascade do |t|
    t.text "url", null: false
    t.json "response_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_api_requests_on_url", unique: true
  end

  create_table "daily_weather_forecasts", force: :cascade do |t|
    t.date "date"
    t.string "summary"
    t.string "high"
    t.string "low"
    t.string "icon"
    t.bigint "weather_report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weather_report_id"], name: "index_daily_weather_forecasts_on_weather_report_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_reports", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.string "condition"
    t.string "temperature"
    t.string "latitude"
    t.string "longitude"
    t.string "icon"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_refresh"
    t.index ["city"], name: "index_weather_reports_on_city"
    t.index ["user_id"], name: "index_weather_reports_on_user_id"
  end

  add_foreign_key "daily_weather_forecasts", "weather_reports"
  add_foreign_key "weather_reports", "users"
end
