require 'clickhouse/rails/config'

module Clickhouse
  module Migrations
    def self.config
      @configuration ||= Clickhouse::Rails::Config.init
    end
  end
end
