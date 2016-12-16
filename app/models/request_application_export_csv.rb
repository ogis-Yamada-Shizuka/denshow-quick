require 'csv'

class RequestApplicationExportCsv
  class << self
    def export(request_applications)
      CSV.generate do |csv|
        csv << %w(機種コード 技術資料番号)
        collect_values(request_applications).each { |value| csv << value }
      end.encode(Encoding::SJIS)
    end

    private

    def collect_values(request_applications)
      values = []
      request_applications.eager_load(:model, :details).each do |request_application|
        request_application.details.each do |detail|
          values << [request_application.model.code, detail.doc_no]
        end
      end
      values.uniq
    end
  end
end
