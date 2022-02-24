require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NowayZA
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")
    config.time_zone = "Europe/Berlin"
    config.noway_puuid = ENV.fetch("RIOT_API_PUUID", "IslvKjK8xB5PEnrJctqRCLrKW7DDLCiYUUSp32_R-M5pvKlyMMdI-KaqhrpbJZf5GKzIammxPBES0g")
    config.api_key = ENV["RIOT_API_KEY"]
  end
end
