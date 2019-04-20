require_relative '../../rails_helper'
require_relative '../../../lib/generators/clickhouse/migration/migration_generator'

RSpec.describe Clickhouse::Generators::MigrationGenerator, type: :generator do
  setup_default_destination

  it 'generates db/clickhouse/migrate/temp.rb' do
    run_generator(['temp'])
    expect(file('db/clickhouse/migrate/001_temp.rb')).to exist
  end
end
