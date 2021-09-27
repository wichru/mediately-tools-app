# frozen_string_literal: true

module Github::Api
  extend self

  MAIN_BRANCH = 'develop'
  REPO_NAME = Rails.application.credentials.github[:repo_name]

  def fetch_file(path:)
    client.contents(REPO_NAME, path: path)
  rescue Octokit::NotFound
    false
  end

  def export_file_commit(file_path:, file_content:, feature_branch:)
    client.create_contents(REPO_NAME, file_path, 'New tool spec', file_content, branch: feature_branch)
  end

  def create_pull_request(feature_branch:)
    client.create_pull_request(REPO_NAME, MAIN_BRANCH, feature_branch, "cerate-#{branch_name}")
  end

  private

  def client
    @client ||= Github::OctokitClient.client
  end
end
