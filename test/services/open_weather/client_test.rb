# frozen_string_literal: true

require "test_helper"

class OpenWeather::ClientTest < ActiveSupport::TestCase
  def setup
    @subject = OpenWeather::Client.new
  end

  def test_gets_geolocation_resource
    stub_get_request("#{geolocation_path}?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_london.json"))
    })

    assert_equal OpenStruct, @subject.get(resource: "geolocation", q: "London").class
  end

  def test_gets_one_call_resource
    stub_get_request("#{one_call_path}&lat=51.5073219&lon=-0.1276474", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })

    assert_equal OpenStruct, @subject.get(resource: "one_call", lat: 51.5073219, lon: -0.1276474).class
  end
end
