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
      build_for_matching_datas
    end

    private

    def build_for_matching_datas
      for_matching_datas = []
      for_matching_data_attributes_arr.each do |attributes|
        for_matching_datas << ForMatchingData.new(attributes)
      end
      for_matching_datas
    end

    def for_matching_data_attributes_arr
      attributes_arr = []
      CSV.foreach(@file, encoding: 'SJIS:UTF-8', col_sep: "\t") do |row|
        attributes = {}
        CSV_COLMUN.each do |key, idx|
          attributes.store(key, row[idx])
        end
        attributes_arr << attributes
      end
      attributes_arr
    end
  end
end
