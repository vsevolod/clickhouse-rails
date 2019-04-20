class Init < Clickhouse::Rails::Migrations::Base
  def self.up
    create_table MIGRATION_TABLE do
      t.string :version
    end
  end
end
