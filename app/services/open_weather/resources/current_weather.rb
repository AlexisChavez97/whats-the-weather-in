# frozen_string_literal: true

module OpenWeather
  module Resources
    class CurrentWeather < Resource
      include ResponseToOpenStruct

      def get(params)
        to_struct(get_request("data/2.5/weather?units=metric", params).body)
      end
    end
  end
end
