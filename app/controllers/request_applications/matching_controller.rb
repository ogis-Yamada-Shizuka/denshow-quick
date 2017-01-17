class RequestApplications::MatchingController < ApplicationController
  def matching
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result.eager_load(:model)
  end

  def matching_result
    @request_application = RequestApplication.find(params[:id])
    @matching_results = RequestApplicationMatcher.match(params[:id])
  end
end
