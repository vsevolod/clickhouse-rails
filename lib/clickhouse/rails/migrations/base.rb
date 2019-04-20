module Clickhouse
  module Rails
    module Migrations
      class Base
        MIGRATION_TABLE = 'schema_migrations'.freeze

        class << self
          attr_accessor :migrations_list

          def inherited(child)
            @migrations_list ||= []
            @migrations_list.push(child)
          end
        end

        def self.run
          @migrations_list.each do |migration|
            migration.up
            migration.add_version
          end
        end

        def self.up; end

        def self.add_version
          Clickhouse.connection.insert_rows(MIGRATION_TABLE) do |row|
            row << { version: __FILE__ }
          end
        end

        def self.create_table(table_name, &block)
          Clickhouse.connection.create_table(table_name, &block)
        end

        def self.fetch_table(table_name, &block)
          return if Clickhouse.connection.exists_table(table_name)

          Clickhouse.connection.create_table(table_name, &block)
        end

        def self.alter_table(table_name)
          @table_info = Clickhouse.connection.describe_table(table_name)
          @table_name = table_name

          yield(table_name)
        end

        def self.fetch_column(column, type)
          return if @table_info.find{|c_info| c_info.first == column.to_s}

          type = type.to_s
                  .gsub(/(^.|_\w)/) {
                    $1.upcase
                  }
                  .gsub("Uint", "UInt")
                  .delete("_")

          Clickhouse.connection.execute("ALTER TABLE #{@table_name} ADD COLUMN #{column} #{type}")
        end
      end
    end
  end
end
