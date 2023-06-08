# frozen_string_literal: true

require "test_helper"

class OpenWeather::CurrentWeatherTest < ActiveSupport::TestCase
  def setup
    @client = OpenWeather::Client.new
  end

  def test_gets_and_sets_attributes
    stub_get_request("data/2.5/weather?lat=51.5073219&lon=-0.1276474&units=metric", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })
    subject = @client.get(resource: "current_weather", lat: 51.5073219, lon: -0.1276474)

    assert_equal subject.main.temp, 284.29
    assert_equal subject.main.humidity, 80
    assert_equal subject.name, "London"
  end
end
