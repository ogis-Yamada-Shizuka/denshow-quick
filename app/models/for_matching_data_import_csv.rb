require 'csv'

class ForMatchingDataImportCsv
  CSV_COLMUN = {
    format_type:  0,
    document_no:  1,
    model_code:   2,
    doc_no:       3,
    doc_type_str: 4,
    sht:          5,
    rev:          6,
    eo_chgno:     7,
    chg_type_str: 8,
    mcl:          9,
    scp_for_smpl: 10,
    scml:         11,
    revision:     12
  }.freeze

  class << self
    def import(file)
      @file = file
      create_for_matching_datas
    end

    private

    def create_for_matching_datas
      ForMatchingData.transaction do
        CSV.foreach(@file, encoding: 'SJIS:UTF-8', col_sep: "\t") do |row|
          attributes = {}
          CSV_COLMUN.each do |key, idx|
            attributes.store(key, row[idx])
          end
          ForMatchingData.create(attributes)
        end
      end
    end
  end
end
