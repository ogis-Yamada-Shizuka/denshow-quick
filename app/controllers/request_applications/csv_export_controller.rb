class RequestApplications::CsvExportController < ApplicationController
  def search
    @q = RequestApplication.ransack(params.fetch(:q, {}).permit(:management_no_cont))
    @request_applications = @q.result.order(created_at: :DESC)
  end

  def export
    if params[:request_application].present?
      request_applications = RequestApplication.where(id: params[:request_application][:ids])
      send_data RequestApplicationExportCsv.export(request_applications), type: 'text/csv; charset=shift_jis', filename: "#{Time.zone.now.to_date}.csv"
    else
      redirect_to search_request_applications_path, alert: t('controller.errors.template.csv_export.not_selected')
    end
  end
end
