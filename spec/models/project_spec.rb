require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Attribute definition' do
    it { is_expected.to respond_to(:name) }
  end

  describe 'validates' do
    subject { project }
    let(:project) { create(:project) }
    it { is_expected.to be_valid }

    describe 'name' do
      context '256文字以上の場合' do
        it { expect(build(:project, name: 'a' * 256)).to be_invalid }
      end
    end
  end
end
