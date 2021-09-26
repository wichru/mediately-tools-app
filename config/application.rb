# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module MediatelyToolsApp
  class Application < Rails::Application
    config.load_defaults 6.1
    config.paths.add 'lib', eager_load: true
  end
end
