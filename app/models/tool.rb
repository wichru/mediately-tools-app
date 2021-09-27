# frozen_string_literal: true

class Tool < ApplicationRecord
  LANGUAGES = %w[en bg cs hr it ro sl sk sr].freeze

  validates :name, presence: true
  validates :language, length: { is: 2 }, presence: true

  after_commit :translation_callback, on: :create

  private

  def translation_callback
    update_json_spec
    send_translation_keys
  end

  def update_json_spec
    update!(json_spec: fetch_json_spec)
  end

  def fetch_json_spec
    json_value = ::Github::FetchJson.new(name, language).call
    return 'translation does not exist'.to_json if json_value == false

    json_value
  end

  def send_translation_keys
    SendTranslationKeyesJob.perform_later(self)
  end
end
