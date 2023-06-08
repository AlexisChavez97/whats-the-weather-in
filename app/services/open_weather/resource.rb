# frozen_string_literal: true

module OpenWeather
  class Resource
    CACHE_POLICY = lambda { 10.minutes.ago }

    attr_reader :client

    def initialize(client)
      @client = client
    end

    private
      def get_request(url, params)
        ApiRequest.cache(request_path(url, params), CACHE_POLICY) do
          handle_response(client.connection.get(url, params))
        end
      end

      def handle_response(response)
        raise StandardError.new(I18n.t("open_weather.errors.not_found")) if response.body.empty?
        raise StandardError.new(I18n.t("open_weather.errors.bad_request")) if response.status == 400

        response
      end

      def request_path(url, query)
        path = URI.encode_www_form(query)
        URI::HTTP.build(path: "/#{url}", query: path).request_uri
      end
  end
end
