# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tool, type: :model do
  context 'schema' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:language).of_type(:string) }
    it { should have_db_column(:json_spec).of_type(:json) }
  end
end
