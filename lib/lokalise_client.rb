# frozen_string_literal: true

module LokaliseClient
  module_function

  def client
    @client ||= Lokalise.client(Rails.application.credentials.lokalise[:api_key])
  end
end
