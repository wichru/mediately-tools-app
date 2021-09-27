# frozen_string_literal: true

require 'monads'

module Lokalise
  class SendTranslationKeys
    def initialize(hash_spec, language)
      @hash_spec = hash_spec
      @language = language
    end

    def call
      Success(hash_spec)
        .bind(method(:filter_hash))
        .bind(method(:flatten_hash))
        .bind(method(:create_payload))
        .bind(method(:send_keys))
    end

    attr_accessor :hash_spec
    attr_reader :language

    private

    def filter_hash(hash_spec)
      string_hashes = LokaliseSettings.filter_hash(hash_spec)

      Success(string_hashes)
    end

    def flatten_hash(string_hashes)
      params_hash = LokaliseSettings.flatten_hash(string_hashes)

      Success(params_hash)
    end

    def create_payload(params_hash)
      payload = params_hash.map do |k, v|
        params(k.to_s, v.to_s, language)
      end

      Success(payload)
    end

    def send_keys(payload)
      response = LokaliseClient.create_keys(payload)
    rescue Lokalise::Error::BadRequest
      response = false

      if response == false
        Failure(response)
      else
        Success(response)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def params(key, value, language)
      {
        key_name: {
          ios: key,
          web: key,
          android: key,
          other: key,
        },
        platforms: %w[ios web android other],
        translations: [
          {
            language_iso: language,
            translation: value,
          },
        ],
      }
    end
    # rubocop:enable Metrics/MethodLength
  end
end
