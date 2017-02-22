require 'rails_helper'
require 'csv'

RSpec.describe Dept, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:project) }
  end

  describe 'validates' do
    subject { dept }
    let(:dept) { create(:dept) }
    it { is_expected.to be_valid }

    describe 'name' do
      context '値がnilの場合' do
        it { expect(build(:dept, name: nil)).to be_invalid }
      end

      context '値がユニークではない場合' do
        subject { same_attribute_dept.valid? }
        let(:same_attribute_dept) { build(:dept, name: dept.name) }

        it { is_expected.to be_falsey }
      end
    end
  end
end
