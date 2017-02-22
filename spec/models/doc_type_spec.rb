require 'rails_helper'
require 'csv'

RSpec.describe DocType, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:name) }
  end

  describe 'validates' do
    subject { doc_type }
    let(:doc_type) { create(:doc_type) }
    it { is_expected.to be_valid }
  end

  describe '半角英小文字が半角英大文字にvalidateすると置換される' do
    subject { doc_type[:name] }
    let(:doc_type) { build(:doc_type) }

    let(:lowercase_value) { 'abc' }
    let(:uppercase_value) { 'abc'.upcase }

    it do
      doc_type[:name] = lowercase_value
      doc_type.validate
      is_expected.to eq uppercase_value
    end
  end

  describe 'CSV import' do
    let(:file) { open('spec/fixtures/files/doc_type_import_test.csv') }
    let(:csv_values) do
      CSV.read(file, encoding: 'SJIS:UTF-8', headers: true).map { |row| row['name'] }
    end

    describe '登録件数の確認' do
      it { expect { DocType.import(file) }.to change { DocType.count }.by csv_values.count }
    end

    describe '登録内容一致の確認' do
      before { DocType.import(file) }
      it do
        DocType.order(:id)[-csv_values.count..-1].each_with_index do |record, i|
          expect(record.name).to eq csv_values[i]
        end
      end
    end
  end
end
