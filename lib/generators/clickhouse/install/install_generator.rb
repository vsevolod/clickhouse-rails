module Clickhouse
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc <<-DESC
        Description:
          Copy clickhouse file to your application
      DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def copy_install_files
        copy_file 'config/clickhouse.yml'
        directory db_migrate_path
      end

      def db_migrate_path
        'db/clickhouse/migrate'
      end
    end
  end
end
