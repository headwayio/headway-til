require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module HrTil
  class Application < Rails::Application
    config.active_record.schema_format = :sql
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Eastern Time (US & Canada)'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'views', '**', '*.{rb,yml}')]
    config.assets.paths = [Rails.root.join('app', 'assets', 'images')]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :options]
      end
    end
  end
end
