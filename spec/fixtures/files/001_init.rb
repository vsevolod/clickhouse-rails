class Init < Clickhouse::Rails::Migrations::Base
  def self.up
    create_table MIGRATION_TABLE do |t|
      t.string :version

      t.engine 'File(TabSeparated)'
    end
  end
end
