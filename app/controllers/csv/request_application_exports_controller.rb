class Csv::RequestApplicationExportsController < ApplicationController
  def index
    @q = RequestApplication.ransack(params.fetch(:q, {}).permit(:management_no_cont))
    @request_applications = @q.result.order(created_at: :DESC)
  end

  def create
  end
end
