# frozen_string_literal: true

require "test_helper"

class OpenWeather::ClientTest < ActiveSupport::TestCase
  def setup
    @subject = OpenWeather::Client.new
  end

  def test_gets_geolocation_resource
    stub_get_request("geo/1.0/direct?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation.json"))
    })

    assert_equal OpenStruct, @subject.get(resource: "geolocation", q: "London").class
  end

  def test_gets_current_weather_resource
    stub_get_request("data/2.5/weather?lat=51.5073219&lon=-0.1276474", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather.json"))
    })

    assert_equal OpenStruct, @subject.get(resource: "current_weather", lat: 51.5073219, lon: -0.1276474).class
  end
end
