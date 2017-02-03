require 'rails_helper'

RSpec.describe OlderRequestApplications::RequestApplicationsController, type: :controller do

  describe 'OlderRequestApplicationsController test' do
    describe 'GET #index' do
      before { get :index }
      it { expect(response.status).to eq(200) }
    end
  end
end
