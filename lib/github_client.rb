# frozen_string_literal: true

module GithubClient
  extend self

  def fetch_file(file_url)
    client.get(file_url)
  rescue Octokit::NotFound
    false
  end

  def create_pull_request(repo_name, branch_name)
    client.create_pull_request(repo_name, 'develop', branch_name, "cerate-#{branch_name}")
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: Rails.application.credentials.github[:access_token])
  end
end
