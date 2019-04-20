require 'rails/railtie'
require 'clickhouse/rails/config'

module Clickhouse
  module Rails
    def self.config
      @configuration ||= Clickhouse::Rails::Config.init
    end

    class Railtie < ::Rails::Railtie
      generators = config.respond_to?(:app_generators) ? config.app_generators : config.generators
      generators.integration_tool :clickhouse
      generators.test_framework :clickhouse

      generators do
        require 'generators/clickhouse/install/install_generator'
      end

      rake_tasks do
        load 'tasks/clickhouse/migrate'
      end
    end
  end
end
