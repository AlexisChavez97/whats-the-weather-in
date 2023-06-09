# frozen_string_literal: true

require "test_helper"

class OpenWeather::OneCallTest < ActiveSupport::TestCase
  def setup
    @client = OpenWeather::Client.new
  end

  def test_gets_and_sets_attributes
    stub_get_request("#{one_call_path}&lat=51.5073219&lon=-0.1276474", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "current_weather_london.json"))
    })
    subject = @client.get(resource: "one_call", lat: 51.5073219, lon: -0.1276474)

    assert_equal subject.current.temp, 285.22
    assert_equal subject.current.humidity, 82
    assert_not_empty subject.daily
  end
end
