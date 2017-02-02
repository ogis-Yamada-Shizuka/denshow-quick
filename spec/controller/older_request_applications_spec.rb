require 'rails_helper'

RSpec.describe OlderRequestApplications::RequestApplicationsController, type: :controller do

  describe 'OlderRequestApplicationsController test' do
    let(:dept) { create(:dept) }
    let(:flow_order) { create(:flow_order, dept: dept) }
    let(:request_application) { create(:request_application) }
    let(:flow) { create(:flow, dept: dept, request_application: request_application) }

    let(:q) { RequestApplication.ransack(nil) }
    let(:request_applications) { q.result.order(:created_at).reverse_order }
    let(:flow_orders) { FlowOrder.order_list }

    describe 'GET #index' do
      before { get :index }
      it { expect(assigns(:request_applications)).to eq request_applications }
      it { expect(assigns(:flow_orders)).to eq flow_orders }

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template(:index) }
    end
  end
end
