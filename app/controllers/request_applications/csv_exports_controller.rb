class RequestApplications::CsvExportsController < ApplicationController
  def search
    @q = RequestApplication.ransack(params.fetch(:q, {}).permit(:management_no_cont))
    @request_applications = @q.result.order(created_at: :DESC)
  end

  def export
    request_applications = RequestApplication.where(id: params[:request_application][:ids])
    send_data RequestApplicationExportCsv.export(request_applications), type: 'text/csv; charset=shift_jis', filename: "#{Time.zone.now.to_date}.csv"
  end
end
