require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Shishkifest
  class Application < Rails::Application
    config.load_defaults 5.1

    config.paths.add 'app/api', glob: '**/*.rb'

    config.time_zone = 'Krasnoyarsk'
    config.active_record.default_timezone = :utc

    additional_paths = %W[
      #{config.root}/app/services
    ]
    config.autoload_paths += additional_paths
    config.eager_load_paths += additional_paths

    config.i18n.default_locale = :ru
  end
end
