# frozen_string_literal: true

require "test_helper"

class WeatherReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid)
    @weather_report = weather_reports(:valid)
    sign_in @user

    stub_get_request("#{geolocation_path}?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_london.json"))
    })

    stub_get_request("#{one_call_path}&lat=51.5073219&lon=-0.1276474", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })
  end

  def test_it_should_get_index
    get weather_reports_path
    assert_response :success
  end

  def test_should_get_new
    get new_weather_report_path
    assert_response :success
  end

  def test_should_show_weather_report
    get new_weather_report_path(@weather_report)
    assert_response :success
  end

  def test_it_should_create_weather_report
    assert_difference("WeatherReport.count") do
      post weather_reports_path, params: { weather_report: { city: "London" } }
    end

    assert_redirected_to weather_reports_path
  end
end
