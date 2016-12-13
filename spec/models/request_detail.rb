require 'rails_helper'

RSpec.describe RequestDetail, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:request_application_id) }
    it { is_expected.to respond_to(:doc_no) }
    it { is_expected.to respond_to(:sht) }
    it { is_expected.to respond_to(:rev) }
    it { is_expected.to respond_to(:eo_chgno) }
    it { is_expected.to respond_to(:mcl) }
    it { is_expected.to respond_to(:scp_for_smpl) }
    it { is_expected.to respond_to(:scml_ln) }
    it { is_expected.to respond_to(:doc_type_id) }
    it { is_expected.to respond_to(:chg_type_id) }
    it { is_expected.to respond_to(:vendor_code) }
  end

  describe 'associations' do
    subject { request_detail }
    let(:request_application) { create(:request_application) }
    let(:doc_type) { create(:doc_type) }
    let(:chg_type) { create(:chg_type) }
    let(:request_detail) do
      create(
        :request_detail,
        request_application: request_application,
        doc_type: doc_type,
        chg_type: chg_type
      )
    end
    it { is_expected.to be_valid }

    context 'request_application' do
      it { expect(request_detail.request_application).to eq request_application }
    end

    context 'doc_type' do
      it { expect(request_detail.doc_type).to eq doc_type }
    end

    context 'chg_type' do
      it { expect(request_detail.chg_type).to eq chg_type }
    end
  end

  describe 'validates' do
    subject { request_detail }
    let(:request_detail) do
      create(
        :request_detail,
        request_application: create(:request_application),
        doc_type: create(:doc_type),
        chg_type: create(:chg_type)
      )
    end
    it { is_expected.to be_valid }


    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
      describe "#{attribute} invalid value validate" do
        # 有効な文字パターン1(半角英数、半角記号、半角カタカナ)
        VALID_VALUES_ONE = %w(A 1 ! ｶﾀｶﾅ).freeze

        # 無効な文字パターン1(全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
        INVALID_VALUES_ONE = %w(ひらがな カタカナ 漢字 ！ Ａ １).freeze

        context '有効な文字パターン1の場合' do
          VALID_VALUES_ONE.each do |valid_value|
            it do
              request_detail[attribute] = valid_value
              is_expected.to be_valid
            end
          end
        end

        context '無効な文字パターン1の場合' do
          INVALID_VALUES_ONE.each do |invalid_value|
            it do
              request_detail[attribute] = invalid_value
              is_expected.to be_invalid
            end
          end
        end
      end
    end

    describe 'vendor_code invalid value validate' do
      # 有効な文字パターン2(半角英数)
      VALID_VALUES_TWO = %w(A 1).freeze

      # 無効な文字パターン2(半角記号、全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
      INVALID_VALUES_TWO = %w(# ひらがな ｶﾀｶﾅ カタカナ 漢字 ！ Ａ １).freeze

      context '有効な文字パターン2の場合' do
        VALID_VALUES_TWO.each do |valid_value|
          it do
            request_detail.vendor_code = valid_value
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン2の場合' do
        INVALID_VALUES_TWO.each do |invalid_value|
          it do
            request_detail.vendor_code = invalid_value
            is_expected.to be_invalid
          end
        end
      end
    end

    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln vendor_code).each do |attribute|
      describe "#{attribute} max length validate" do
        context '256文字以上の場合' do
          it do
            request_detail[attribute] = 'a' * 256
            is_expected.to be_invalid
          end
        end
      end
    end
  end

  describe '半角英小文字が半角英大文字にvalidateすると置換される' do
    subject { request_detail }
    let(:request_detail) do
      create(
        :request_detail,
        request_application: create(:request_application),
        doc_type: create(:doc_type),
        chg_type: create(:chg_type)
      )
    end
    it { is_expected.to be_valid }

    let(:lowercase_value) { 'abc' }
    let(:uppercase_value) { 'abc'.upcase }

    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln vendor_code).each do |attribute|
      context attribute.to_s do
        it do
          request_detail[attribute] = lowercase_value
          request_detail.validate
          expect(request_detail[attribute]).to eq uppercase_value
        end
      end
    end
  end
end
