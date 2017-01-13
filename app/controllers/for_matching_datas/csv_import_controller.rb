class ForMatchingDatas::CsvImportController < ApplicationController
  def import
    @q = ForMatchingData.ransack(params[:q])
    @for_matching_datas = params[:q].present? ? @q.result.order(document_no: :ASC) : []
  end

  def import_csv
    ForMatchingDataImportCsv.import(params[:file].tempfile)
    redirect_to for_matching_datas_import_path, notice: 'matching data imported.'
  rescue
    redirect_to for_matching_datas_import_path, alert: 'import failed.'
  end
end
