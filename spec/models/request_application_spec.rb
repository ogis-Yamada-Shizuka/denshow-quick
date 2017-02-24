require 'rails_helper'

RSpec.describe RequestApplication, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:management_no) }
    it { is_expected.to respond_to(:request_date) }
    it { is_expected.to respond_to(:preferred_date) }
    it { is_expected.to respond_to(:project_id) }
    it { is_expected.to respond_to(:model_id) }
    it { is_expected.to respond_to(:section_id) }
    it { is_expected.to respond_to(:emargency) }
    it { is_expected.to respond_to(:filename) }
    it { is_expected.to respond_to(:close) }
    it { is_expected.to respond_to(:memo) }
  end

  describe 'validates' do
    subject { request_application.valid? }

    let(:request_application) do
      create(
        :request_application,
        model: create(:model),
        section: create(:section),
        project: create(:project)
      )
    end

    describe '日付の前後関係' do
      before do
        request_application.request_date = Time.zone.today
        request_application.preferred_date = preferred_date
      end

      context '要求日 < 入手希望日の場合' do
        let(:preferred_date) { request_application.request_date.since(1.day) }
        it do
          is_expected.to be_truthy
        end
      end

      context '要求日 == 入手希望日の場合' do
        let(:preferred_date) { request_application.request_date }
        it do
          is_expected.to be_truthy
        end
      end

      context '要求日 > 入手希望日の場合' do
        let(:preferred_date) { request_application.request_date.ago(1.day) }
        it do
          is_expected.to be_falsey
        end
      end
    end

    %i(management_no model_id section_id request_date preferred_date).each do |attribute|
      describe "#{attribute} presence validate" do
        context '値がnilの場合' do
          before { request_application[attribute] = nil }
          it do
            is_expected.to be_falsey
          end
        end
      end
    end

    describe 'management_no' do
      context '値がユニークではない場合' do
        subject { same_attribute_request_application.valid? }

        let(:same_attribute_request_application) do
          build(
            :request_application,
            request_application.attributes
          )
        end

        it { is_expected.to be_falsey }
      end
    end
  end

  describe 'compare_to_matching_datas method' do
    let(:request_application) do
      create(
        :request_application,
        model: create(:model, code: 'A01'),
        section: create(:section),
        project: create(:project)
      )
    end

    describe '一致、不一致の結果がハッシュとして返却される' do
      context '全て一致する場合' do
        subject { request_application.compare_to_matching_datas.all? { |_key, value| value[:matched].present? } }

        before do
          create_list(:request_detail_same_attribute_as_fmd, 5, request_application: request_application)
          create_list(:fmd_same_attribute_as_detail, 5)
        end

        it { is_expected.to be_truthy }
      end

      context '不一致の detail が存在する場合' do
        subject { request_application.compare_to_matching_datas.any? { |_key, value| value[:unmatched_details].present? } }

        before do
          create(:request_detail_same_attribute_as_fmd, request_application: request_application, sht: 'ERR1')
          create(:fmd_same_attribute_as_detail)
        end

        it { is_expected.to be_truthy }
      end

      context '不一致の for_matching_data が存在する場合' do
        subject { request_application.compare_to_matching_datas.any? { |_key, value| value[:unmatched_for_matching_datas].present? } }

        before do
          create(:request_detail_same_attribute_as_fmd, request_application: request_application)
          create(:fmd_same_attribute_as_detail, sht: 'ERR1')
        end

        it { is_expected.to be_truthy }
      end
    end

    describe '不一致の detail の attributes の key が返却される' do
      let(:unmatched_keys) { %i(sht rev) }
      before do
        create(:request_detail_same_attribute_as_fmd, request_application: request_application, sht: 'ERR1', rev: 'ERR2')
        create(:fmd_same_attribute_as_detail)
      end

      subject do
        [].tap do |keys|
          request_application.compare_to_matching_datas.each do |_key, result|
            result[:unmatched_details].each { |h| h[:unmatched_attributes].each { |key| keys << key } }
          end
        end
      end
      it { is_expected.to eq unmatched_keys }
    end
  end
end
