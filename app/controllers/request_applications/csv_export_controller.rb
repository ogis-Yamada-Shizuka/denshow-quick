class RequestApplications::CsvExportController < ApplicationController
  def search
    @q = RequestApplication.ransack(params.fetch(:q, {}).permit(:management_no_cont))
    @request_applications = @q.result.order(created_at: :DESC)
  end

  def export
    if params[:request_application].present?
      request_applications = RequestApplication.where(id: params[:request_application][:ids])
      send_data RequestApplicationExportCsv.export(request_applications), type: 'text/csv; charset=shift_jis', filename: filename
    else
      redirect_to search_request_applications_path, alert: t('message.template.csv_export.management_no_is_not_selected')
    end
  end

  private

  def filename
    now = Time.zone.now
    "#{t('file_name.export_csv_for_k_peace')}_#{now.strftime('%Y%m%d')}_#{now.strftime('%H%M')}.csv"
  end
end
