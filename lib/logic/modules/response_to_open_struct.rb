# frozen_string_literal: true

require "ostruct"
require "json"

module ResponseToOpenStruct
  def to_struct(response)
    if response.is_a?(Hash)
      structify_hash(response)
    elsif response.is_a?(Array)
      unwrap_object(response.first)
    elsif response.is_a?(String)
      to_struct(JSON.parse(response))
    else
      response
    end
  end

  private
    def unwrap_object(object)
      if object.is_a?(Hash)
        structify_hash(object)
      elsif object.is_a?(Array)
        object.map { |item| unwrap_object(item) }
      else
        object
      end
    end

    # rubocop:disable Performance/OpenStruct
    def structify_hash(hash)
      OpenStruct.new(hash.transform_values { |value| unwrap_object(value) })
    end
end
