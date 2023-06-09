# frozen_string_literal: true

require "test_helper"

class DailyWeatherForecastTest < ActiveSupport::TestCase
  def setup
    @subject = DailyWeatherForecast.new
    @subject.weather_report = weather_reports(:valid)
  end

  test "should save daily weather forecast" do
    @subject.date = Date.today
    @subject.summary = "Expect a day of partly cloudy with clear spells"
    @subject.high = "70"
    @subject.low = "60"
    @subject.icon = "01d"

    assert @subject.save
  end

  test "should not save daily weather forecast without date" do
    @subject.summary = "Expect a day of partly cloudy with clear spells"
    @subject.high = "70"
    @subject.low = "60"
    @subject.icon = "01d"

    assert_not @subject.save
  end

  test "should not save daily weather forecast without high" do
    @subject.date = Date.today
    @subject.summary = "Expect a day of partly cloudy with clear spells"
    @subject.low = "60"
    @subject.icon = "01d"

    assert_not @subject.save
  end

  test "should not save daily weather forecast without low" do
    @subject.date = Date.today
    @subject.summary = "Expect a day of partly cloudy with clear spells"
    @subject.high = "70"
    @subject.icon = "01d"

    assert_not @subject.save
  end

  test "should not save daily weather forecast without icon" do
    @subject.date = Date.today
    @subject.summary = "Expect a day of partly cloudy with clear spells"
    @subject.high = "70"
    @subject.low = "60"

    assert_not @subject.save
  end

  test "should not save daily weather forecast without summary" do
    @subject.date = Date.today
    @subject.high = "70"
    @subject.low = "60"
    @subject.icon = "01d"

    assert_not @subject.save
  end
end
