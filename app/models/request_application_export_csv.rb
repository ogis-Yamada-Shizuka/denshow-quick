require 'csv'

class RequestApplicationExportCsv
  class << self
    # rubocop:disable all
    # メソッドチェインするとrubocopエラーが出る(バグ？)ので無効化
    def export(request_applications)
      CSV.generate { |csv|
        csv << %w(機種コード 技術資料番号)
        collect_values(request_applications).each { |value| csv << value }
      }.encode(Encoding::SJIS)
    end
    # rubocop:enable all

    private

    def collect_values(request_applications)
      values = []
      request_applications.each do |request_application|
        request_application.details.each do |detail|
          values << [request_application.model.code, detail.doc_no]
        end
      end
      values.uniq
    end
  end
end
