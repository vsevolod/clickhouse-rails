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

  describe '#insert_row' do
    let(:inserted_rows) { CustomTable.rows.to_a }
    let(:row) { { 'field' => 'a' } }

    it 'add the row' do
      CustomTable.insert_row(row)

      expect(inserted_rows).to eq([['a']])
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

    context 'when row has empty attributes' do
      let(:rows) { [{}] }

      it 'adds empty row' do
        CustomTable.insert_rows(rows)

        expect(inserted_rows).to eq([['']])
      end
    end
  end

  describe '#prepare_row' do
    subject(:method) { CustomTable.prepare_row(row) }

    context 'when row has wrong type' do
      # TODO: implement array logic
      let(:row) { ['a'] }

      it 'raises an error' do
        expect { method }.to raise_error(Clickhouse::Table::WrongTypeRowError)
      end
    end

    context 'when row has extra fields' do
      let(:row) { { 'field' => 'a', 'extra_field' => 'b' } }

      it 'leaves only existing fields' do
        is_expected.to eq('field' => 'a')
      end
    end
  end
end
