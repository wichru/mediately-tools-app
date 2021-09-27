# frozen_string_literal: true

class SendTranslationKeyesJob < ApplicationJob
  def perform(tool_obj)
    Lokalise::SendTranslationKeys.new(tool_obj.json_spec, tool_obj.language).call
  end
end
