class RequestApplications::MatchingController < ApplicationController
  def matching
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result
  end

  def matching_result
    @matching_results = RequestApplicationMatcher.match(params[:id])
  end
end
