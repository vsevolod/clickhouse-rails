require_relative '../../../clickhouse/rails'
require_relative '../../../clickhouse/rails/migrations/base'

namespace :clickhouse do
  namespace :db do
    desc 'Migrate clickhouse migrations'
    task migrate: :environment do
      path_to_migrations = './db/clickhouse/migrate/*.rb'
      Dir[path_to_migrations].sort.each { |file| require file }

      Clickhouse::Rails::Migrations::Base.run_up
    end
  end
end
