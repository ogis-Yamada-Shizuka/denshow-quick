class RequestApplications::MatchingController < ApplicationController
  def matching
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result.eager_load(:model)
  end

  def matching_result
    @request_application = RequestApplication.find(params[:id])
    @matching_results = @request_application.compare_to_matching_datas
  end
end
