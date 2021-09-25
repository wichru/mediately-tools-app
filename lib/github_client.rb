# frozen_string_literal: true

module GithubClient
  module_function

  def client
    @client ||= Octokit::Client.new(access_token: Rails.application.credentials.github[:access_token])
  end
end
