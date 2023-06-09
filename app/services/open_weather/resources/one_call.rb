# frozen_string_literal: true

module OpenWeather
  module Resources
    class OneCall < Resource
      include ResponseToOpenStruct

      def get(params)
        to_struct(get_request("data/3.0/onecall", params.merge(units: "metric", exclude: "minutely, hourly")).body)
      end
    end
  end
end
