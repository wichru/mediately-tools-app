# frozen_string_literal: true

module LokaliseClient
  extend self

  PROJECT_ID = Rails.application.credentials.lokalise[:project_id]

  def create_keys(key_params)
    client.create_keys(PROJECT_ID, key_params)
  end

  private

  def client
    @client ||= Lokalise.client(Rails.application.credentials.lokalise[:api_key])
  end
  #
  # def key_params
  #   {
  #     keys: [
  #       {
  #         key_name: key_name,
  #         platforms: %w[ios web android other],
  #         translations: [
  #           {
  #             language_iso: 'en',
  #             translation: 'Welcome',
  #           },
  #         ],
  #       },
  #     ],
  #   }
  # end
end
