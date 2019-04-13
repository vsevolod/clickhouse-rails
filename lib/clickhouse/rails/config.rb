require 'yaml'

module Clickhouse
  module Rails
    module Config
      class ConfigurationNotFound < NameError; end

      CLICKHOUSE_ROOT = File.expand_path((defined?(::Rails) && ::Rails.root.to_s.length > 0) ? ::Rails.root : '.') unless defined?(CLICKHOUSE_ROOT)
      DEFAULT_CONFIG_PATH = File.join(CLICKHOUSE_ROOT, 'config', 'clickhouse.yml')

      def self.init(config_path = DEFAULT_CONFIG_PATH)
        exists = config_path && File.exists?(config_path)
        raise ConfigurationNotFound, "could not find the \"#{config_path}\" configuration file" unless exists

        data = defined?(ERB) ? ERB.new(config_path).result : File.read(config_path)
        YAML.load(data)[defined?(::Rails) ? ::Rails.env : ENV['CLICKHOUSE_ENV']]
      end
    end
  end
end
