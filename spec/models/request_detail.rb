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

    # 有効な文字パターン1(半角英数、半角記号、半角カタカナ)
    VALID_VALUES_ONE = %w(A 1 ! ｶﾀｶﾅ).freeze

    # 無効な文字パターン1(全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
    INVALID_VALUES_ONE = %w(ひらがな カタカナ 漢字 ！ Ａ １).freeze

    # 有効な文字パターン2(半角英数)
    VALID_VALUES_TWO = %w(A 1).freeze

    # 無効な文字パターン2(半角記号、全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
    INVALID_VALUES_TWO = %w(# ひらがな ｶﾀｶﾅ カタカナ 漢字 ！ Ａ １).freeze

    describe 'doc_no validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.doc_no = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.doc_no = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.doc_no = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'sht validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.sht = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.sht = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.sht = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'rev validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.rev = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.rev = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.rev = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'eo_chgno validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.eo_chgno = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.eo_chgno = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.eo_chgno = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'mcl validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.mcl = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.mcl = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.mcl = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'scp_for_smpl validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.scp_for_smpl = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.scp_for_smpl = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.scp_for_smpl = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'scml_ln validate' do
      context '有効な文字パターン1の場合' do
        VALID_VALUES_ONE.each do |valid_string|
          it do
            request_detail.scml_ln = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン1の場合' do
        INVALID_VALUES_ONE.each do |invalid_string|
          it do
            request_detail.scml_ln = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.scml_ln = 'a' * 256
          is_expected.not_to be_valid
        end
      end
    end

    describe 'vendor_code validate' do
      context '有効な文字パターン2の場合' do
        VALID_VALUES_TWO.each do |valid_string|
          it do
            request_detail.vendor_code = valid_string
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターン2の場合' do
        INVALID_VALUES_TWO.each do |invalid_string|
          it do
            request_detail.vendor_code = invalid_string
            is_expected.not_to be_valid
          end
        end
      end

      context '256文字以上の場合' do
        it do
          request_detail.vendor_code = 'a' * 256
          is_expected.not_to be_valid
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

    context 'doc_no' do
      it do
        request_detail.doc_no = lowercase_value
        request_detail.valid?
        expect(request_detail.doc_no).to eq uppercase_value
      end
    end

    context 'sht' do
      it do
        request_detail.sht = lowercase_value
        request_detail.valid?
        expect(request_detail.sht).to eq uppercase_value
      end
    end

    context 'rev' do
      it do
        request_detail.rev = lowercase_value
        request_detail.valid?
        expect(request_detail.rev).to eq uppercase_value
      end
    end

    context 'eo_chgno' do
      it do
        request_detail.eo_chgno = lowercase_value
        request_detail.valid?
        expect(request_detail.eo_chgno).to eq uppercase_value
      end
    end

    context 'mcl' do
      it do
        request_detail.mcl = lowercase_value
        request_detail.valid?
        expect(request_detail.mcl).to eq uppercase_value
      end
    end

    context 'scp_for_smpl' do
      it do
        request_detail.scp_for_smpl = lowercase_value
        request_detail.valid?
        expect(request_detail.scp_for_smpl).to eq uppercase_value
      end
    end

    context 'scml_ln' do
      it do
        request_detail.scml_ln = lowercase_value
        request_detail.valid?
        expect(request_detail.scml_ln).to eq uppercase_value
      end
    end

    context 'vendor_code' do
      it do
        request_detail.vendor_code = lowercase_value
        request_detail.valid?
        expect(request_detail.vendor_code).to eq uppercase_value
      end
    end
  end
end
