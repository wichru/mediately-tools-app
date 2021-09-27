# frozen_string_literal: true

module LokaliseSettings
  module_function

  def filter_hash(hash)
    hash.each_with_object({}) do |(key, value), acc|
      acc[key] = value if value.is_a?(String)
      acc[key] = filter_hash(value) if value.is_a?(Hash)
    end
  end

  def flatten_hash(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a?(Hash)
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}_#{h_k}"] = h_v
        end
      else
        h[k] = v
      end
    end
  end
end
