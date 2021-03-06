require File.expand_path('../boot', __FILE__)

<% unless options[:skip_active_record] -%>
require 'rails/all'
<% else -%>
# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"
<% end -%>

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module <%= app_const_base %>
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
<% if options[:skip_javascript] -%>
    config.action_view.javascript_expansions[:defaults] = %w()
<% elsif options[:javascript] == 'prototype' -%>
    config.action_view.javascript_expansions[:defaults] = %w(prototype effects dragdrop controls rails)
<% else -%>
    # config.action_view.javascript_expansions[:defaults] = %w(prototype effects dragdrop controls rails)
<% end -%>

<% if options[:skip_test_unit] -%>
    config.generators.test_framework = false
<% end -%>

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

<% unless options[:skip_active_record] -%>
    # Enable IdentityMap for Active Record, to disable set to false or remove the line below.
    config.active_record.identity_map = true
<% end -%>

    # Enable the asset pipeline
    config.assets.enable = true
  end
end
