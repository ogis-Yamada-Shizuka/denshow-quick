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

  let(:request_application) do
    create(
      :request_application,
      model: create(:model),
      section: create(:section),
      project: create(:project)
    )
  end

  describe 'associations' do
    subject { request_detail }
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
        request_application: request_application,
        doc_type: create(:doc_type),
        chg_type: create(:chg_type)
      )
    end
    it { is_expected.to be_valid }

    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
      describe "#{attribute} invalid value validate" do
        # 有効な文字パターン(半角英数、半角記号、半角カタカナ)
        VALID_VALUES = %w(A 1 ! ｶﾀｶﾅ).freeze

        # 無効な文字パターン(全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
        INVALID_VALUES = %w(ひらがな カタカナ 漢字 ！ Ａ １).freeze

        context '有効な文字パターンの場合' do
          VALID_VALUES.each do |valid_value|
            it do
              request_detail[attribute] = valid_value
              is_expected.to be_valid
            end
          end
        end

        context '無効な文字パターンの場合' do
          INVALID_VALUES.each do |invalid_value|
            it do
              request_detail[attribute] = invalid_value
              is_expected.to be_invalid
            end
          end
        end
      end
    end

    describe 'vendor_code invalid value validate' do
      # 有効な文字パターン(半角英数)
      VALID_VALUES = %w(A 1).freeze

      # 無効な文字パターン(半角記号、全角ひらがな、全角カタカナ、漢字、全角記号、全角英数字)
      INVALID_VALUES = %w(# ひらがな ｶﾀｶﾅ カタカナ 漢字 ！ Ａ １).freeze

      context '有効な文字パターンの場合' do
        VALID_VALUES.each do |valid_value|
          it do
            request_detail.vendor_code = valid_value
            is_expected.to be_valid
          end
        end
      end

      context '無効な文字パターンの場合' do
        INVALID_VALUES.each do |invalid_value|
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
        request_application: request_application,
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

  describe 'compare_attributes method' do
    let(:attributes) do
      {
        doc_no: 'DOC-TEST-001',
        doc_type: 'GHI',
        sht: 'S01',
        rev: 'A',
        eo_chgno: 'N99',
        chg_type: 'BVSR',
        mcl: '(D)',
        scp_for_smpl: 'ｲ-6#2',
        scml_ln: 'A-N'
      }
    end

    let(:request_detail) do
      create(
        :request_detail,
        request_application: request_application, doc_no: attributes[:doc_no],
        sht: attributes[:sht], rev: attributes[:rev],
        eo_chgno: attributes[:eo_chgno], mcl: attributes[:mcl],
        scp_for_smpl: attributes[:scp_for_smpl], scml_ln: attributes[:scml_ln],
        doc_type: create(:doc_type, name: attributes[:doc_type]),
        chg_type: create(:chg_type, name: attributes[:chg_type])
      )
    end

    describe 'attributesに設定した値が規定のキーと値で返却される' do
      subject { request_detail.compare_attributes }
      it { is_expected.to eq attributes }
    end

    describe '同一の値を設定したForMatchingDataと比較すると True が得られる' do
      subject { request_detail.compare_attributes == for_matching_data.compare_attributes }

      let(:for_matching_data) do
        create(
          :for_matching_data,
          doc_no: attributes[:doc_no], doc_type_str: attributes[:doc_type],
          sht: attributes[:sht], eo_chgno: attributes[:eo_chgno],
          chg_type_str: attributes[:chg_type], mcl: attributes[:mcl],
          scp_for_smpl: attributes[:scp_for_smpl], scml: attributes[:scml_ln]
        )
      end

      it { is_expected.to be true }
    end
  end
end
