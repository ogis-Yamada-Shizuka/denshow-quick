class ForMatchingDatas::CsvImportController < ApplicationController
  def import
    # TODO: 絞込機能追加時に全件取得外す
    @for_matching_datas = ForMatchingData.all
  end

  def import_csv
    ForMatchingDataImportCsv.import(params[:file].tempfile)
    redirect_to for_matching_datas_import_path, notice: 'matching data imported.'
  rescue
    redirect_to for_matching_datas_import_path, alert: 'import failed.'
  end
end
