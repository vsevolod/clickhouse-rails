require_relative 'rails_helper'

class CustomTable
  include Clickhouse::Table
end

describe Clickhouse::Table do
  before do
    with_table 'custom_tables' do |t|
      t.string 'field'

      t.engine 'File(TabSeparated)'
    end
  end

  describe '#table_columns' do
    subject(:method) { CustomTable.table_columns }

    it 'returns all info' do
      is_expected.to eq('field' => 'String')
    end
  end

  describe '#insert_rows' do
    let(:inserted_rows) { CustomTable.rows.to_a }

    context 'when row is a hash' do
      let(:rows) { [{ 'field' => 'a' }, { 'field' => 2 }] }

      it 'adds two rows' do
        CustomTable.insert_rows(rows)

        expect(inserted_rows).to eq([['a'], ['2']])
      end
    end

    context 'when row is an array' do
      # TODO: implement array logic
      let(:rows) { [['a'], ['2']] }

      it 'raises an error' do
        expect { CustomTable.insert_rows(rows) }
          .to raise_error(Clickhouse::Table::WrongTypeRowError)
      end
    end

    context 'when row has empty attributes' do
      let(:rows) { [{}] }

      it 'adds empty row' do
        CustomTable.insert_rows(rows)

        expect(inserted_rows).to eq([['']])
      end
    end
  end
end
