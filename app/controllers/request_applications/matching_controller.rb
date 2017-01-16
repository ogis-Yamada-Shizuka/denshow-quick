class RequestApplications::MatchingController < ApplicationController
  def matching
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result
  end

  def mathcing_result; end
end
