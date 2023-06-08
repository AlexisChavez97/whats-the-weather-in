# frozen_string_literal: true

require "test_helper"

class OpenWeather::GeolocationTest < ActiveSupport::TestCase
  def setup
    @client = OpenWeather::Client.new
  end

  def test_gets_and_sets_attributes
    stub_get_request("geo/1.0/direct?q=London", response: {
      status: 200, body: File.read(Rails.root.join("test", "fixtures", "files", "geolocation_london.json"))
    })
    subject = @client.get(resource: "geolocation", q: "London")

    assert_equal 51.5073219, subject.lat
    assert_equal(-0.1276474, subject.lon)
  end
end
