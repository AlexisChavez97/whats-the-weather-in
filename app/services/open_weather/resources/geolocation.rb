# frozen_string_literal: true

module OpenWeather
  module Resources
    class Geolocation < Resource
      include ResponseToOpenStruct

      def get(params)
        to_struct(get_request("geo/1.0/direct", params).body)
      end
    end
  end
end
