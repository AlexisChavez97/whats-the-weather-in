# frozen_string_literal: true

require "test_helper"

class ApiRequestTest < ActiveSupport::TestCase
  def test_itshould_not_save_api_request_without_url
    subject = ApiRequest.new

    assert_no_difference("ApiRequest.count") do
      subject.save
    end
  end

  def test_it_should_save_subject_with_url
    subject = ApiRequest.new(url: "#{geolocation_path}?q=London")

    assert_difference "ApiRequest.count", 1 do
      subject.save
    end
  end

  def test_it_should_not_save_subject_with_same_url
    subject_1 = ApiRequest.new(url: "#{geolocation_path}?q=London")
    subject_2 = ApiRequest.new(url: "#{geolocation_path}?q=London")

    assert_difference "ApiRequest.count", 1 do
      subject_1.save
      subject_2.save
    end
  end

  def test_it_should_save_subject_with_different_url
    subject_1 = ApiRequest.new(url: "#{geolocation_path}?q=London")
    subject_2 = ApiRequest.new(url: "#{geolocation_path}?q=Manchester")

    assert_difference "ApiRequest.count", 2 do
      subject_1.save
      subject_2.save
    end
  end
end
