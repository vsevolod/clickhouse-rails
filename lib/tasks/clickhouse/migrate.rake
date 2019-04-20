namespace :clickhouse do
  namespace :db do
    desc 'Migrate clickhouse migrations'
    task :migrate do
      Clickhouse::Rails::Migrations::Base.run
    end
  end
end
