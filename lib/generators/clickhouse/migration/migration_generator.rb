module Clickhouse
  module Generators
    class MigrationGenerator < ::Rails::Generators::NamedBase
      include ::Rails::Generators::Migration

      desc <<-DESC
        Description:
          Add migration for clickhouse database
      DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        number = current_migration_number(dirname) + 1
        format('%03d', number)
      end

      def create_migration_file
        set_local_assign!
        migration_template @migration_template, File.join(db_migrate_path, "#{file_name}.rb")
      end

      private

      def set_local_assign!
        @migration_template = 'db/migrate/template.rb'
      end

      def db_migrate_path
        'db/clickhouse/migrate'
      end
    end
  end
end
