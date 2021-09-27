# frozen_string_literal: true

class Tool < ApplicationRecord
  def update_json_spec
    update!(json_spec: fetch_json_spec)
  end

  def fetch_json_spec
    json_value = ::Github::FetchJson.new(name, language).call
    return 'translation does not exist'.to_json if json_value == false

    json_value
  end
end
