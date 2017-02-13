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
    let(:request_application) do
      create(
        :request_application,
        model: create(:model),
        section: create(:section),
        project: create(:project)
      )
    end

    describe '日付の前後関係' do
      subject { request_application }

      context '要求日 < 入手希望日の場合' do
        it do
          request_application[:request_date] = Time.zone.today
          request_application[:preferred_date] = request_application.request_date.since(1.day)
          is_expected.to be_valid
        end
      end

      context '要求日 == 入手希望日の場合' do
        it do
          request_application[:request_date] = Time.zone.today
          request_application[:preferred_date] = Time.zone.today
          is_expected.to be_valid
        end
      end

      context '要求日 > 入手希望日の場合' do
        it do
          request_application[:request_date] = Time.zone.today
          request_application[:preferred_date] = request_application.request_date.ago(1.day)
          is_expected.to be_invalid
        end
      end
    end
  end
end
