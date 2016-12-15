require 'csv'

class RequestApplicationExportCsv
  class << self
    def export(request_applications)
      csv_data = CSV.generate do |csv|
        headers = %w(機種コード 技術資料番号)
        csv << headers
        request_applications.each do |request_application|
          request_application.details.each do |detail|
            values = [request_application.model.code, detail.doc_no]
            csv << values
          end
        end
      end
      csv_data.encode(Encoding::SJIS)
    end
  end
end
