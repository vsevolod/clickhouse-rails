module Clickhouse
  module Table
    class WrongTypeRowError < StandardError; end

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def table_name
        @table_name ||= to_s.tableize
      end

      def insert_row(row)
        return if row.nil?

        connection.insert_rows(table_name) do
          complete_row = prepare_row(block_given? ? yield(row) : row)

          [complete_row]
        end
      end
      alias :create :insert_row

      def insert_rows(batch_rows)
        connection.insert_rows(table_name) do |table_rows|
          batch_rows.each do |row|
            next if row.nil?

            complete_row = prepare_row(block_given? ? yield(row) : row)

            table_rows << complete_row
          end

          table_rows
        end
      end

      def table_columns
        @table_columns ||=
          connection.select_rows(
            select: 'name, type',
            from: 'system.columns',
            where: "table = '#{table_name}'"
          ).to_h
      end

      def rows(attributes = {})
        connection.select_rows(attributes.merge(from: table_name))
      end

      def empty_row
        @empty_row ||= table_columns.map do |k, v|
          value =
            case v
            when /UInt/ then 0
            when /Float/ then 0.0
            else
              ''
            end

          [k, value]
        end.to_h
      end

      def prepare_row(row)
        return empty_row.merge(row.stringify_keys) if row.is_a?(Hash)

        raise WrongTypeRowError, "#{row.inspect} has wrong type"
      end

      def connection
        ::Clickhouse.connection
      end
    end
  end
end
