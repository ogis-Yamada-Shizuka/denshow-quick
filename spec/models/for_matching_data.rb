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
      subject { same_value_object }
      let!(:for_matching_data) { create(:for_matching_data) }
      let(:same_value_object) { build(:for_matching_data) }

      context '同一の組合せが既に存在するか確認' do
        it do
          exist_record = ForMatchingData.find_by(document_no: same_value_object.document_no, revision: same_value_object.revision)
          expect(exist_record.present?).to be_truthy
        end
      end

      context '同一の値が既に存在した場合' do
        it do
          is_expected.to be_invalid
        end
      end
    end
  end
end
