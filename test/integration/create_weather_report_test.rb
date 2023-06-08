# frozen_string_literal: true

require "test_helper"

class CreateWeatherReportTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid)
    @weather_report = weather_reports(:valid)
    sign_in @user

    stub_get_request("geo/1.0/direct?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_london.json"))
    })
    stub_get_request("data/2.5/weather?lat=51.5073219&lon=-0.1276474&units=metric", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })
  end

  def test_it_should_create_new_weather_report
    assert_difference "WeatherReport.count", 1 do
      post weather_reports_path, params: { weather_report: { city: "London" } }
    end

    assert_redirected_to weather_reports_path
  end

  def test_it_should_not_create_new_weather_report_if_city_is_not_found
    stub_get_request("geo/1.0/direct?q=fakecity", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_fake.json"))
    })

    assert_no_difference "WeatherReport.count" do
      post weather_reports_path, params: { weather_report: { city: "fakecity" } }
    end

    assert_response :unprocessable_entity
  end

  def test_it_should_create_new_api_request_for_each_resource
    assert_difference "ApiRequest.count", 2 do
      post weather_reports_path, params: { weather_report: { city: "London" } }
    end

    assert_redirected_to weather_reports_path
  end

  def test_it_should_only_create_new_api_request_first_time_if_the_query_is_repeated
    assert_difference "ApiRequest.count", 2 do
      post weather_reports_path, params: { weather_report: { city: "London" } }
      post weather_reports_path, params: { weather_report: { city: "London" } }
    end

    assert_redirected_to weather_reports_path
  end

  def test_it_should_create_new_api_request_for_each_resource_each_time_its_called_with_different_query
    stub_get_request("geo/1.0/direct?q=Manchester", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_manchester.json"))
    })
    stub_get_request("data/2.5/weather?lat=53.4794892&lon=-2.2451148&units=metric", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_manchester.json"))
    })

    assert_difference "ApiRequest.count", 4 do
      post weather_reports_path, params: { weather_report: { city: "London" } }
      post weather_reports_path, params: { weather_report: { city: "Manchester" } }
    end

    assert_redirected_to weather_reports_path
  end
end
