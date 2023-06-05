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
        case response.status
        when 400
          raise StandardError, response.body["message"]
        when 401
          raise StandardError, response.body["message"]
        when 402
          raise StandardError, response.body["message"]
        when 403
          raise StandardError, "Forbidden"
        when 404
          raise StandardError, response.body["message"]
        when 500
          raise StandardError, "Internal Server Error"
        end
        response
      end
  end
end
