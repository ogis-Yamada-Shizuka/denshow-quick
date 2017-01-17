require 'active_support'
require 'active_support/core_ext'

class RequestApplicationMatcher
  class << self
    def match(request_application_id)
      @request_application = RequestApplication.eager_load(:model, :details).find(request_application_id)
      @request_details = @request_application.details.eager_load(:doc_type, :chg_type).order(doc_no: :ASC).to_a
      @for_matching_datas = ForMatchingData.where(model_code: @request_application.model.code).order(doc_no: :ASC).to_a
      compare
    end

    private

    def compare
      @results = []
      @request_details.each do |detail|
        compare_detail(detail)
      end
      @results
    end

    def compare_detail(request_detail)
      is_matched = false
      key = "#{@request_application.model.code} #{request_detail.doc_no}"
      @for_matching_datas.each do |for_matching_data|
        next unless request_detail[:doc_no] == for_matching_data[:doc_no]
        if same_value?(request_detail, for_matching_data)
          @results << { key: key, is_match: true, request_detail: request_detail_display_value(request_detail), for_matching_data: for_matching_data.document_no }
          is_matched = true
        else
          @results << { key: key, is_match: false, for_matching_data: for_matching_data.document_no }
        end
      end
      @results << { key: key, is_match: false, request_detail: request_detail_display_value(request_detail) } unless is_matched
    end

    def same_value?(request_detail, for_matching_data)
      request_detail_attributes = convert_request_detail_attribute_name(request_detail)
      for_matching_data_attributes = convert_for_matching_data_attribute_name(for_matching_data)
      request_detail_attributes.each do |key, value|
        return false unless value == for_matching_data_attributes[key]
      end
      true
    end

    def convert_request_detail_attribute_name(request_detail)
      attributes = compare_attributes
      attributes[:doc_no] = request_detail.doc_no
      attributes[:doc_type] = request_detail.doc_type.name
      attributes[:sht] = request_detail.sht
      attributes[:rev] = request_detail.rev
      attributes[:eo_chgno] = request_detail.eo_chgno
      attributes[:chg_type] = request_detail.chg_type&.name
      attributes[:mcl] = request_detail.mcl
      attributes[:scp_for_smpl] = request_detail.scp_for_smpl
      attributes[:scml_ln] = request_detail.scml_ln
      attributes
    end

    def convert_for_matching_data_attribute_name(for_matching_data)
      attributes = compare_attributes
      attributes[:doc_no] = for_matching_data.doc_no
      attributes[:doc_type] = for_matching_data.doc_type_str
      attributes[:sht] = for_matching_data.sht
      attributes[:rev] = for_matching_data.revision
      attributes[:eo_chgno] = for_matching_data.eo_chgno
      attributes[:chg_type] = for_matching_data.chg_type_str
      attributes[:mcl] = for_matching_data.mcl
      attributes[:scp_for_smpl] = for_matching_data.scp_for_smpl
      attributes[:scml_ln] = for_matching_data.scml
      attributes
    end

    def compare_attributes
      { doc_no: nil, doc_type: nil, sht: nil, rev: nil, eo_chgno: nil, chg_type: nil, mcl: nil, soc_for_smpl: nil, scml: nil }
    end

    def request_detail_display_value(request_detail)
      # TODO: doc_typeにもとづいて並び順を変更する必要有るか要検討
      attributes = convert_request_detail_attribute_name(request_detail)
      display_value = @request_application.model.code
      attributes.each_value do |value|
        next if value.blank?
        display_value += "|#{value}"
      end
      display_value
    end
  end
end
