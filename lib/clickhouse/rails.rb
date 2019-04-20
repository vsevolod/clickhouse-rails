require 'rails'
require 'clickhouse/rails/config'

module Clickhouse
  module Rails
    def self.init!
      Clickhouse.establish_connection(config)
    end

    def self.config(config_path = nil)
      @config ||= Clickhouse::Rails::Config.init(config_path)
    end

    class Railtie < ::Rails::Railtie
      generators =
        if config.respond_to?(:app_generators)
          config.app_generators
        else
          config.generators
        end
      generators.integration_tool :clickhouse
      generators.test_framework :clickhouse

      generators do
        require 'generators/clickhouse/install/install_generator'
      end

      rake_tasks do
        load 'tasks/clickhouse/db/migrate.rake'
      end

      config.to_prepare do
        Clickhouse::Rails.init!
      end
    end
  end
end
