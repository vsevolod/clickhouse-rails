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

          def run_up
            return unless @migrations_list

            @migrations_list.each do |migration|
              next if migration.passed?

              migration.up
              migration.add_version
            end
          end

          def passed?
            return false unless table_exists?(MIGRATION_TABLE)

            @rows ||= connection.select_row(select: 'version', from: MIGRATION_TABLE)
            @rows.include?(name)
          rescue Clickhouse::QueryError
            false
          end

          def up; end

          def add_version
            connection.insert_rows(MIGRATION_TABLE) do |row|
              row << { version: name }
            end
          end

          def table_exists?(table_name)
            connection.execute("EXISTS TABLE #{table_name}").strip == '1'
          end

          def soft_create_table(table_name, &block)
            return if table_exists?(table_name)

            create_table(table_name, &block)
          end

          def soft_drop_table(table_name)
            return unless table_exists?(table_name)

            drop_table(table_name)
          end

          delegate :create_table, to: :connection
          delegate :drop_table, to: :connection

          def alter_table(table_name)
            @table_info = connection.describe_table(table_name)
            @table_name = table_name

            yield(table_name)
          end

          def fetch_column(column, type)
            return if @table_info.find{|c_info| c_info.first == column.to_s}

            type = type.to_s
                    .gsub(/(^.|_\w)/) {
                      $1.upcase
                    }
                    .gsub("Uint", "UInt")
                    .delete("_")

            connection.execute("ALTER TABLE #{@table_name} ADD COLUMN #{column} #{type}")
          end

          def connection
            Clickhouse.connection
          end
        end
      end
    end
  end
end