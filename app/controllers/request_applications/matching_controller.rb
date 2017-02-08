class RequestApplications::MatchingController < ApplicationController
  def matching
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result.eager_load(:model)
  end

  def matching_result
    @request_application = RequestApplication.find(params[:id])
    respond_to do |format|
      format.html do
        @matching_results = @request_application.compare_to_matching_datas
      end
      format.csv do
        send_data @request_application.export_matching_result_csv, type: 'text/csv; charset=shift_jis', filename: "#{t('file_name.matching_result_export_csv')}_#{Time.zone.now.to_date}.csv"
      end
    end
  end
end
