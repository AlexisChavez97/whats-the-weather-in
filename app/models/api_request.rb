# frozen_string_literal: true

class ApiRequest < ApplicationRecord
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy)
    find_or_initialize_by(url:).cache(cache_policy) do
      yield if block_given?
    end
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call
      yield_result = yield
      update(updated_at: Time.zone.now, response_data: yield_result)
      yield_result
    else
      self
    end
  end

  def body
    response_data&.fetch("body", nil)
  end
end
