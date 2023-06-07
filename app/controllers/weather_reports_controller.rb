# frozen_string_literal: true

class WeatherReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @weather_reports = current_user.weather_reports.recent
  end

  def new
    @weather_report = WeatherReport.new
  end

  def create
    result = ::CreateWeatherReport.call(
      client: OpenWeather::Client.new,
      params: weather_report_params,
      user: current_user
    )
    if result.success?
      @weather_report = result.weather_report

      respond_to do |format|
        format.html { redirect_to weather_reports_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def weather_report_params
      params.require(:weather_report).permit(:city)
    end
end
