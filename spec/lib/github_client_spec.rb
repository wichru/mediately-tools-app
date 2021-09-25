# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubClient do
  describe '#fetch_user' do
    subject(:fetch_user) { described_class.client.user }

    context 'when client is valid' do
      it 'fetch user', :aggregate_failures, vcr: { cassette_name: 'fetch_user' } do
        expect(fetch_user).to be_present
      end
    end
  end
end
