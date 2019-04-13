require 'spec_helper.rb'

describe Clickhouse::Rails::Config do
  describe '.init' do
    subject(:init) { described_class.init }

    context 'when config file does not exists' do
      it { expect { init }.to raise_error(Clickhouse::Rails::Config::ConfigurationNotFound) }
    end

    context 'when config file exists' do
      let(:path) { File.dirname(__FILE__) + '/fixtures/files/clickhouse.yml' }

      before do
        stub_const('Clickhouse::Rails::Config::DEFAULT_CONFIG_PATH', path)
      end

      it { expect{ init }.not_to raise_error }
    end
  end
end
