module Clickhouse
  module Rails
    module Generators
      module Macros
        def set_default_destination
          destination File.expand_path('../../../tmp', __FILE__)
        end

        def setup_default_destination
          set_default_destination
          before { prepare_destination }
        end
      end

      def self.included(klass)
        klass.extend(Macros)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Clickhouse::Rails::Generators, type: :generator
end
