require 'rails_helper'
require 'csv'

RSpec.describe Model, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:code) }
  end

  describe 'validates' do
    subject { model }
    let(:model) { create(:model) }
    it { is_expected.to be_valid }

    describe 'code invalid value validate' do
      # 有効な文字パターン(半角英数)
      VALID_VALUES = %w(A a 1).freeze

      # 無効な文字パターン(全角ひらがな、全角カタカナ、半角カタカナ、漢字、全角記号、半角記号、全角英数字)
      INVALID_VALUES = %w(ひらがな カタカナ ｶﾀｶﾅ 漢字 ！ ! Ａ １).freeze

      context '有効な文字パターンの場合' do
        VALID_VALUES.each do |valid_value|
          it do
            model.code = valid_value
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターンの場合' do
        INVALID_VALUES.each do |invalid_value|
          it do
            model.code = invalid_value
            is_expected.to be_invalid
          end
        end
      end
    end
  end

  describe 'CSV import' do
    let(:file) { open('spec/fixtures/files/model_import_test.csv') }
    let(:csv_values) do
      CSV.read(file, encoding: 'SJIS:UTF-8', headers: true).map { |row| row['code'] }
    end
    before do
      Model.import(file)
    end

    it '読み込んだCSVと登録された件数が同一である' do
      expect(Model.all.size).to eq csv_values.length
    end

    it '読み込んだCSVとレコードに登録された値が同一である' do
      Model.all.each_with_index do |record, i|
        expect(record.code).to eq csv_values[i]
      end
    end
  end
end
