require_relative '../../rails_helper'
require_relative '../../../lib/generators/clickhouse/install/install_generator'

RSpec.describe Clickhouse::Generators::InstallGenerator, type: :generator do
  setup_default_destination

  it 'generates config/clickhouse.yml' do
    run_generator
    expect(file('config/clickhouse.yml')).to exist
  end

  it 'generates db/clickhouse/migrate/001_init.rb' do
    run_generator
    expect(file('db/clickhouse/migrate/001_init.rb')).to exist
  end
end
