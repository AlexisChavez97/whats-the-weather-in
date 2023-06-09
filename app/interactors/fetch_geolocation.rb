# frozen_string_literal: true

class FetchGeolocation
  include Interactor

  def call
    context.geolocation = fetch_geolocation

    rescue StandardError => e
      context.fail!(message: e.message)
  end

  private
    def fetch_geolocation
      context.client.get(resource: "geolocation", q: context.params[:city])
    end
end
