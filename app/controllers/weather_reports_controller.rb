# frozen_string_literal: true

class WeatherReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @weather_reports = current_user.weather_reports.recent
  end

  def new
    @weather_report = WeatherReport.new
  end

  def show
    @weather_report = WeatherReport.find(params[:id])
  end

  def update
    result = ::UpdateWeatherReport.call(
      client: OpenWeather::Client.new,
      weather_report: WeatherReport.find(params[:id])
    )

    if result.success?
      @weather_report = result.weather_report

      respond_to do |format|
        format.html { redirect_to weather_report_path(@weather_report) }
        format.turbo_stream
      end
    else
      render turbo_stream: turbo_stream.update("errors", partial: "shared/error_messages", locals: { errors: result.message })
    end
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
      render turbo_stream: turbo_stream.update("errors", partial: "shared/error_messages", locals: { errors: result.message }), status: :unprocessable_entity
    end
  end

  private
    def weather_report_params
      params.require(:weather_report).permit(:city)
    end
end
