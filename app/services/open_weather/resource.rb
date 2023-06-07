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
          raise StandardError.new("Not found: OpenWeather API returned an empty response")
        elsif response.status == 400
          raise StandardError.new("OpenWeather API returned a bad request")
        else
          response
        end
      end
  end
end
