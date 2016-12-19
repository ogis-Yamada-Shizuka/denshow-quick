class ForMatchingDatas::CsvImportController < ApplicationController
  def import; end

  def import_csv
    for_matching_datas = ForMatchingDataImportCsv.import(params[:file].tempfile)
    for_matching_datas.each(&:save)
    redirect_to for_matching_datas_import_path, notice: 'matching data imported.'
  rescue
    redirect_to for_matching_datas_import_path, alert: 'import failed.'
  end
end
