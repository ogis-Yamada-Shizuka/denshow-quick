require 'active_support'
require 'active_support/core_ext'
require 'roo'

class RequestApplicationImportExcel
  REQUEST_CELL = {
    management_no:  [1, 3],
    request_origin: [2, 3],
    request_date:   [3, 3],
    preferred_date: [4, 3],
    model_code:     [5, 3]
  }.freeze

  DETAIL_COLMUN = {
    doc_no:       2,
    doc_type:     3,
    sht:          4,
    rev:          5,
    eo_chgno:     6,
    chg_type:     7,
    mcl:          8,
    scp_for_smpl: 9,
    scml_ln:      10,
    vendor_code:  11
  }.freeze

  DETAIL_START_ROW = 8

  class << self
    def import(file)
      @sheet = Roo::Excelx.new(file)
      build_request_application
    end

    private

    def build_request_application
      RequestApplication.new(request_application_attributes)
    end

    def request_application_attributes
      attributes = read_request_excel_data
      attributes.store(:details_attributes, read_details_excel_data)
      convert_request_value_to_record_id!(attributes)
      convert_detail_value_to_record_id!(attributes[:details_attributes])

      # request_applicationに2015年仕様に関連したexcelに存在しない値を詰める
      attributes[:emargency] = false
      attributes[:close] = false

      attributes
    end

    def convert_request_value_to_record_id!(attributes)
      attributes[:model_id] = Model.find_by(code: attributes[:model_code])&.id
      attributes[:section_id] = Section.find_by(name: attributes[:request_origin])&.id
      attributes.delete(:model_code)
      attributes.delete(:request_origin)
    end

    def convert_detail_value_to_record_id!(details_attributes)
      details_attributes.each do |attributes|
        attributes[:doc_type_id] = DocType.find_by(name: attributes[:doc_type])&.id
        attributes[:chg_type_id] = ChgType.find_by(name: attributes[:chg_type])&.id
        attributes.delete(:doc_type)
        attributes.delete(:chg_type)
      end
    end

    def read_request_excel_data
      attributes_hash = {}
      REQUEST_CELL.each do |key, position|
        row = position[0]
        col = position[1]
        attributes_hash.store(key, @sheet.cell(row, col))
      end
      attributes_hash
    end

    def read_details_excel_data
      attributes_arr = []
      (DETAIL_START_ROW..@sheet.last_row).each do |row|
        attributes_hash = {}
        DETAIL_COLMUN.each do |key, col|
          attributes_hash.store(key, @sheet.cell(row, col))
        end
        break if attributes_hash[:doc_no].blank?
        attributes_arr << attributes_hash
      end
      attributes_arr
    end
  end
end
