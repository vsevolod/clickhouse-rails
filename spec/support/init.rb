RSpec.shared_context 'with init migration' do
  let(:config_file) { file_fixture('clickhouse.yml') }
  let(:file) { file_fixture('001_init.rb') }
  let(:migration_table) { described_class::MIGRATION_TABLE }

  before do
    require file.realpath

    Clickhouse::Rails.config(config_file.realpath.to_s)
    Clickhouse::Rails.init!

    described_class.soft_drop_table(migration_table)
    Init.up
  end
end
