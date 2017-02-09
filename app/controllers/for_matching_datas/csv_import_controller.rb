class ForMatchingDatas::CsvImportController < ApplicationController
  def import
    @q = ForMatchingData.ransack(params[:q])
    if params[:q]&.values.any?(&:present?)
      @for_matching_datas = @q.result.order(document_no: :ASC)
    else
      @for_matching_datas = @q.result.none
      flash.now[:alert] = t('errors.template.search.condition_is_not_selected')
    end
  end

  def import_csv
    ForMatchingDataImportCsv.import(params[:file].tempfile)
    redirect_to for_matching_datas_import_path, notice: 'matching data imported.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to for_matching_datas_import_path, alert: e.record.errors.full_messages.join('<br>')
  rescue
    redirect_to for_matching_datas_import_path, alert: 'import failed.'
  end
end
