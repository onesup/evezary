require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Evezary
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.enabled = true
    config.time_zone = 'Asia/Seoul'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'devise', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ko
    config.assets.precompile += ['application.js', 'application.css', 'admin.js', 'admin.css']
  end
end
