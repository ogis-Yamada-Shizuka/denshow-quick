require 'rails_helper'

RSpec.describe Flow, type: :model do
  describe 'Attribute definition' do
    let(:dept) { create(:dept) }
    let!(:flow_order) { create(:flow_order, dept: dept) }
    it { is_expected.to respond_to(:request_application) }
    it { is_expected.to respond_to(:order) }
    it { is_expected.to respond_to(:dept_id) }
    it { is_expected.to respond_to(:history_no) }
    it { is_expected.to respond_to(:memo) }
  end

  describe 'initialize' do
    subject { flow }
    let(:dept) { create(:dept) }
    let!(:flow_order) { create(:flow_order, dept: dept) }
    let(:flow) { build(:flow) }
    it { is_expected.to be_valid }

    it 'history_noに 1 が設定されること' do
      expect(flow.history_no).to eq 1
    end

    it 'initialize時にflow_orderを元に設定されること' do
      expect(flow.order).to eq flow_order.order
      expect(flow.dept).to eq flow_order.dept
    end

    context 'flow_orderが複数存在する場合' do
      before do
        flow_order.update(order: 2)
        create(:flow_order, dept: create(:dept, name: '技術情報課'), order: 1)
      end

      it 'orderの降順で設定されること' do
        expect(build(:flow).dept.name).to eq '技術情報課'
      end
    end
  end
end
