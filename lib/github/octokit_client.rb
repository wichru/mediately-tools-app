# frozen_string_literal: true

module Github::OctokitClient
  module_function

  ACCESS_TOKEN = Rails.application.credentials.github[:access_token]

  def client
    @client ||= Octokit::Client.new(access_token: ACCESS_TOKEN)
  end
end
