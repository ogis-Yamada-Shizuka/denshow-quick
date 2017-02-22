require 'rails_helper'
require 'csv'

RSpec.describe ChgType, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:name) }
  end

  describe '半角英小文字が半角英大文字にvalidateすると置換される' do
    subject { chg_type[:name] }
    let(:chg_type) { build(:chg_type) }

    let(:lowercase_value) { 'abc' }
    let(:uppercase_value) { 'abc'.upcase }

    it do
      chg_type[:name] = lowercase_value
      chg_type.validate
      is_expected.to eq uppercase_value
    end
  end

  describe 'CSV import' do
    let(:file) { open('spec/fixtures/files/chg_type_import_test.csv') }
    let(:csv_values) do
      CSV.read(file, encoding: 'SJIS:UTF-8', headers: true).map { |row| row['name'] }
    end

    describe '登録件数の確認' do
      it { expect { ChgType.import(file) }.to change { ChgType.count }.by csv_values.count }
    end

    describe '登録内容一致の確認' do
      before { ChgType.import(file) }
      it do
        ChgType.order(:id)[-csv_values.count..-1].each_with_index do |record, i|
          expect(record.name).to eq csv_values[i]
        end
      end
    end
  end
end
