class ForMatchingDatas::CsvImportController < ApplicationController
  before_action :initialize_q, only: :import

  def import
    if params[:q].blank? || params[:q].values.all?(&:blank?)
      @for_matching_datas = @q.result.none
      flash.now[:alert] = t('message.template.search.condition_is_not_selected') if params[:q].present?
    else
      @for_matching_datas = @q.result.order(document_no: :ASC)
    end
  end

  def import_csv
    ForMatchingDataImportCsv.import(params[:file].tempfile)
    redirect_to for_matching_datas_import_path, notice: t('message.template.csv_import.import_success')
  rescue ActiveRecord::RecordInvalid => e
    redirect_to for_matching_datas_import_path, alert: e.record.errors.full_messages.join('<br>')
  rescue
    redirect_to for_matching_datas_import_path, alert: t('message.template.csv_import.import_failed')
  end

  private

  def initialize_q
    @q = ForMatchingData.ransack(params[:q])
  end
end
