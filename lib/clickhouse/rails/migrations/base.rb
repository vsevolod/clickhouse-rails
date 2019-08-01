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

              run_migration(migration)
            end
          end

          def passed?
            return false unless table_exists?(MIGRATION_TABLE)

            @rows ||= connection.select_rows(select: 'version', from: MIGRATION_TABLE).flatten
            @rows.include?(name)
          rescue Clickhouse::QueryError
            false
          end

          def up; end

          def add_version
            connection.insert_rows(MIGRATION_TABLE, names: ['version']) do |row|
              row << [name]
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

          def create_table(table_name, &block)
            logger.info "# >======= Create #{table_name} ========"
            connection.create_table(table_name, &block)
          end

          def drop_table(table_name, &block)
            logger.info "# >======= Drop #{table_name} ========"
            connection.drop_table(table_name, &block)
          end

          def alter_table(table_name)
            @table_info = connection.describe_table(table_name)
            @table_name = table_name

            yield(table_name)
          end

          def fetch_column(column, type)
            return if @table_info.find { |c_info| c_info.first == column.to_s }

            type = type.to_s.gsub(/(^.|_\w)/) do
              Regexp.last_match(1).upcase
            end
            type = type.gsub('Uint', 'UInt').delete('_')

            query = "ALTER TABLE #{@table_name} ADD COLUMN #{column} #{type}"
            logger.info(query)
            connection.execute(query)
          end

          def run_migration(migration)
            logger.info "# >========== #{migration.name} ==========="
            migration.up
            migration.add_version
          rescue Clickhouse::QueryError => e
            logger.info "# Error #{e.class}:"
            logger.info "#  #{e.message}"
          ensure
            logger.info "# <========== #{migration.name} ===========\n\n"
          end

          def connection
            Clickhouse.connection
          end

          def logger
            Logger.new(STDOUT)
          end
        end
      end
    end
  end
end
