# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def stub_get_request(path, response:)
    stub_request(:get, "https://api.openweathermap.org/#{path}").
      with(headers: {
        "Accept": "*/*",
        "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "User-Agent": "Faraday v2.7.5",
        "X-Api-Key": ENV["OPEN_WEATHER_API_KEY"]
      }).to_return(response)
  end

  def geolocation_path
    "geo/1.0/direct"
  end

  def one_call_path
    "data/3.0/onecall?exclude=minutely, hourly&units=metric"
  end
end
