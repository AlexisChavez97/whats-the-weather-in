# frozen_string_literal: true

module OpenWeather
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private
      def get_request(url, params)
        handle_response(client.connection.get(url, params))
      end

      def handle_response(response)
        if response.body.empty?
          raise StandardError.new(I18n.t("open_weather.errors.not_found"))
        elsif response.status == 400
          raise StandardError.new(I18n.t("open_weather.errors.bad_request"))
        else
          response
        end
      end
  end
end
