ENV['RAILS_ENV'] ||= 'test'

require 'rails'
require 'action_view/railtie'
require 'action_controller/railtie'
require 'rails/generators'

require 'ammeter/init'

require_relative '../lib/clickhouse-rails'
require_relative 'support/generators'
require_relative 'support/init'
