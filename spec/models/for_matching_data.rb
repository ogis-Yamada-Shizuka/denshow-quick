require 'rails_helper'

RSpec.describe ForMatchingData, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:format_type) }
    it { is_expected.to respond_to(:document_no) }
    it { is_expected.to respond_to(:model_code) }
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

    %i(format_type document_no model_code doc_type_str sht rev eo_chgno chg_type_str mcl scp_for_smpl scml revision).each do |attribute|
      describe "#{attribute} max length validate" do
        context '256文字以上の場合' do
          it do
            for_matching_data[attribute] = 'a' * 256
            is_expected.to be_invalid
          end
        end
      end
    end

    describe '複合ユニーク制約(document_no, revision)' do
      context '同一の値が既に存在した場合' do
        it do
          attributes = { document_no: 'KP／PICTURE／AAA／R01／N99／BVSR／(D)／ｲ-6#2／A-N／A', revision: 'A' }
          expect(create(:for_matching_data, attributes)).to be_valid
          expect(build(:for_matching_data, attributes)).to be_invalid
        end
      end
    end
  end
end
