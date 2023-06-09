# frozen_string_literal: true

require "test_helper"

class WeatherReportTest < ActiveSupport::TestCase
  def setup
    @subject = WeatherReport.new
    @subject.user = users(:valid)
  end

  test "should save weather report" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.latitude = 34.0522
    @subject.longitude = -118.2437
    @subject.icon = "01d"
    @subject.last_refresh = Time.current

    assert @subject.save
  end

  test "should not save weather report without city" do
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.latitude = 34.0522
    @subject.longitude = -118.2437
    @subject.icon = "01d"
    @subject.last_refresh = Time.current

    assert_not @subject.save
  end

  test "should not save weather report without condition" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.temperature = 70
    @subject.latitude = 34.0522
    @subject.longitude = -118.2437
    @subject.icon = "01d"
    @subject.last_refresh = Time.current

    assert_not @subject.save
  end

  test "should not save weather report without temperature" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.latitude = 34.0522
    @subject.longitude = -118.2437
    @subject.icon = "01d"

    assert_not @subject.save
  end

  test "should not save weather report without latitude" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.longitude = -118.2437
    @subject.icon = "01d"
    @subject.last_refresh = Time.current

    assert_not @subject.save
  end

  test "should not save weather report without longitude" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.latitude = 34.0522
    @subject.icon = "01d"
    @subject.last_refresh = Time.current

    assert_not @subject.save
  end

  test "should not save weather report without icon" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.latitude = 34.0522
    @subject.last_refresh = Time.current

    assert_not @subject.save
  end

  test "should not save weather report without last_refresh" do
    @subject.city = "Los Angeles"
    @subject.state = "California"
    @subject.condition = "Sunny"
    @subject.temperature = 70
    @subject.latitude = 34.0522

    assert_not @subject.save
  end

  test "should update last refresh correctly" do
    subject = weather_reports(:valid)
    current_last_refresh = subject.last_refresh
    subject.update(city: "New York")

    assert_not_equal current_last_refresh, subject.reload.last_refresh
  end
end
