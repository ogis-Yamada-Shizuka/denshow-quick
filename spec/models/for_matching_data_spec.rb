require 'rails_helper'

RSpec.describe ForMatchingData, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:format_type) }
    it { is_expected.to respond_to(:document_no) }
    it { is_expected.to respond_to(:model_code) }
    it { is_expected.to respond_to(:doc_no) }
    it { is_expected.to respond_to(:doc_type_str) }
    it { is_expected.to respond_to(:sht) }
    it { is_expected.to respond_to(:rev) }
    it { is_expected.to respond_to(:eo_chgno) }
    it { is_expected.to respond_to(:chg_type_str) }
    it { is_expected.to respond_to(:mcl) }
    it { is_expected.to respond_to(:scp_for_smpl) }
    it { is_expected.to respond_to(:scml) }
    it { is_expected.to respond_to(:revision) }
  end

  describe 'validates' do
    subject { for_matching_data }
    let(:for_matching_data) { create(:for_matching_data) }
    it { is_expected.to be_valid }

    %i(format_type document_no model_code doc_no doc_type_str sht rev eo_chgno chg_type_str mcl scp_for_smpl scml revision).each do |attribute|
      describe "#{attribute} max length validate" do
        context '256文字以上の場合' do
          it do
            for_matching_data[attribute] = 'a' * 256
            is_expected.to be_invalid
          end
        end
      end
    end

    describe 'ユニーク制約(document_no)' do
      context '同一の値が既に存在した場合' do
        it do
          attributes = { document_no: 'KP／AA10／PICTURE／AAA／R01／N99／BVSR／(D)／ｲ-6#2／A-N／A' }
          expect(create(:for_matching_data, attributes)).to be_valid
          expect(build(:for_matching_data, attributes)).to be_invalid
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

    let(:for_matching_data) do
      create(
        :for_matching_data,
        doc_no: attributes[:doc_no], doc_type_str: attributes[:doc_type],
        sht: attributes[:sht], eo_chgno: attributes[:eo_chgno],
        chg_type_str: attributes[:chg_type], mcl: attributes[:mcl],
        scp_for_smpl: attributes[:scp_for_smpl], scml: attributes[:scml_ln]
      )
    end

    describe 'attributesに設定した値が規定のキーと値で返却される' do
      subject { for_matching_data.compare_attributes }
      it { is_expected.to eq attributes }
    end

    describe '値が nil もしくは 空文字 の場合は該当するキーが返却されない' do
      before do
        build(:for_matching_data, doc_no: nil, sht: '')
      end

      %i(doc_no sht).each do |key|
        subject { for_matching_data.compare_attributes.key?(key) }
        it { is_expected.to be_truthy }
      end
    end

    describe '返却される key の rev の値は revision に設定した値が返却される' do
      subject { for_matching_data.compare_attributes[:rev] }
      before do
        build(:for_matching_data, rev: 'rev', revision: 'revision')
      end

      it { is_expected.to eq for_matching_data.revision }
    end

    describe '同一の値を設定した RequestDetail と比較すると True が得られる' do
      subject { for_matching_data.compare_attributes == request_detail.compare_attributes }

      let(:request_detail) do
        build(
          :request_detail,
          doc_no: attributes[:doc_no],
          sht: attributes[:sht],
          rev: attributes[:rev],
          eo_chgno: attributes[:eo_chgno],
          mcl: attributes[:mcl],
          scp_for_smpl: attributes[:scp_for_smpl],
          scml_ln: attributes[:scml_ln],
          doc_type: create(:doc_type, name: attributes[:doc_type]),
          chg_type: create(:chg_type, name: attributes[:chg_type])
        )
      end

      it { is_expected.to be_truthy }
    end
  end
end
