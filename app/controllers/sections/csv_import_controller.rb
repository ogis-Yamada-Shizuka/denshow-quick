class Sections::CsvImportController < ApplicationController
  def import
    Section.import(params[:file].tempfile)
    redirect_to sections_path, notice: t('message.template.csv_import.import_success')
  rescue
    redirect_to sections_path, alert: t('message.template.csv_import.import_failed')
  end
end
