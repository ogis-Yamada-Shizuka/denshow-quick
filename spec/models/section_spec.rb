require 'rails_helper'
require 'csv'

RSpec.describe Section, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:name) }
  end

  describe 'CSV import' do
    let(:file) { open('spec/fixtures/files/section_import_test.csv') }
    let(:csv_values) do
      CSV.read(file, encoding: 'SJIS:UTF-8', headers: true).map { |row| row['name'] }
    end

    describe '登録件数の確認' do
      it { expect { Section.import(file) }.to change { Section.count }.by csv_values.count }
    end

    describe '登録内容一致の確認' do
      before { Section.import(file) }
      it do
        Section.order(:id)[-csv_values.count..-1].each_with_index do |record, i|
          expect(record.name).to eq csv_values[i]
        end
      end
    end
  end
end
