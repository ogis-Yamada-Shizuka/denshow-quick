module RequestApplication::Matcher
  # TODO: sp-03のwish終わり次第突合せ処理のテストコードを書く
  def compare_to_matching_datas
    @for_matching_datas = ForMatchingData.where(model_code: model.code).order(doc_no: :ASC)
    details.includes(:doc_type, :chg_type).order(doc_no: :ASC).flat_map { |detail| compare_to detail }
  end

  private

  def compare_to(detail)
    key = "#{model.code} #{detail.doc_no}"
    if @for_matching_datas.all? { |for_matching_data| detail[:doc_no] != for_matching_data[:doc_no] }
      return { key: key, match: false, detail: detail_values_for_display(detail) }
    end

    @for_matching_datas.select { |r| r if r.doc_no == detail.doc_no }.map do |for_matching_data|
      if convert_detail_attribute_names(detail) == convert_for_matching_data_attribute_names(for_matching_data)
        { key: key, match: true, detail: detail_values_for_display(detail), for_matching_data: for_matching_data.document_no }
      else
        { key: key, match: false, for_matching_data: for_matching_data.document_no }
      end
    end
  end

  def detail_values_for_display(detail)
    # TODO: doc_typeにもとづいて並び順を変更する必要有るか要検討
    convert_detail_attribute_names(detail).values.delete_if(&:blank?).unshift(model.code).join('|')
  end

  def convert_detail_attribute_names(detail)
    {
      doc_no: detail.doc_no,
      doc_type: detail.doc_type.name,
      sht: detail.sht,
      rev: detail.rev,
      eo_chgno: detail.eo_chgno,
      chg_type: detail.chg_type&.name,
      mcl: detail.mcl,
      scp_for_smpl: detail.scp_for_smpl,
      scml_ln: detail.scml_ln
    }
  end

  def convert_for_matching_data_attribute_names(for_matching_data)
    {
      doc_no: for_matching_data.doc_no,
      doc_type: for_matching_data.doc_type_str,
      sht: for_matching_data.sht,
      rev: for_matching_data.revision,
      eo_chgno: for_matching_data.eo_chgno,
      chg_type: for_matching_data.chg_type_str,
      mcl: for_matching_data.mcl,
      scp_for_smpl: for_matching_data.scp_for_smpl,
      scml_ln: for_matching_data.scml
    }
  end
end
