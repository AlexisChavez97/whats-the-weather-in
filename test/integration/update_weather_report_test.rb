# frozen_string_literal: true

require "test_helper"

class UpdateWeatherReportTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @weather_report = weather_reports(:valid)
    @user = users(:valid)
    sign_in @user

    stub_get_request("#{geolocation_path}?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_london.json"))
    })
    stub_get_request("#{one_call_path}&lat=51.5073219&lon=-0.1276474", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })
  end

  def test_it_should_update_weather_report
    get weather_report_path(@weather_report)
    current_temperature = @weather_report.temperature

    put weather_report_path

    assert_not_equal current_temperature, @weather_report.reload.temperature
  end
end
