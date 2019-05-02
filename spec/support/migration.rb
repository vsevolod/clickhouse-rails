def with_table(table_name, &block)
  Clickhouse::Rails::Migrations::Base.soft_drop_table(table_name)
  Clickhouse::Rails::Migrations::Base.create_table(table_name, &block)
end
