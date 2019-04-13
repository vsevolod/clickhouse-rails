require 'clickhouse/rails/config'

module Clickhouse
  module Rails
    def self.config
      @configuration ||= Clickhouse::Rails::Config.init
    end
  end
end
