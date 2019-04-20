require 'yaml'

module Clickhouse
  module Rails
    module Config
      class ConfigurationNotFound < NameError; end

      CLICKHOUSE_ROOT = File.expand_path(::Rails.root.present? ? ::Rails.root : '.')
      DEFAULT_CONFIG_PATH = File.join(CLICKHOUSE_ROOT, 'config', 'clickhouse.yml')

      def self.init(config_path = nil)
        config_path ||= DEFAULT_CONFIG_PATH
        exists = config_path && File.exist?(config_path)
        unless exists
          raise ConfigurationNotFound, "could not find the \"#{config_path}\" configuration file"
        end

        content = File.read(config_path)
        data = defined?(ERB) ? ERB.new(content).result : content
        source = YAML.safe_load(data)[defined?(::Rails) ? ::Rails.env : ENV['CLICKHOUSE_ENV']]
        config_mapper(source)
      end

      def self.config_mapper(source)
        {
          urls: source['hosts'].split(','),
          username: source['username'],
          password: source['password']
        }
      end
    end
  end
end
