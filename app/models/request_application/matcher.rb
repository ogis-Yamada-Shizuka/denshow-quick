module RequestApplication::Matcher
  # TODO: sp-03のwish終わり次第突合せ処理のテストコードを書く
  def compare_to_matching_datas
    @for_matching_datas = ForMatchingData.where(model_code: model.code).order(doc_no: :ASC)
    details.group(:doc_no).order(doc_no: :ASC).pluck(:doc_no).flat_map { |detail| compare_to detail }
  end

  private

  def compare_to(doc_no)
    key = "#{model.code} #{doc_no}"
    results = []
    target_details = details.includes(:doc_type, :chg_type).where(doc_no: doc_no).to_a
    target_for_matching_datas = @for_matching_datas.select { |for_matching_data| doc_no == for_matching_data[:doc_no] }
    # 一致した detail と for_matching_data を詰めて対象の配列から削除する
    target_details.delete_if do |detail|
      match = false
      target_for_matching_datas.delete_if do |for_matching_data|
        if convert_detail_attribute_names(detail) == convert_for_matching_data_attribute_names(for_matching_data)
          results << { key: key, match: true, detail: convert_detail_attribute_names(detail), for_matching_data: convert_for_matching_data_attribute_names(for_matching_data) }
          match = true
        end
      end
      match
    end
    # 一致しなかった detail と for_matching_data を詰める
    results.concat target_details.map { |detail| { key: key, match: false, detail: convert_detail_attribute_names(detail) } }
    results.concat target_for_matching_datas.map { |for_matching_data| { key: key, match: false, for_matching_data: convert_for_matching_data_attribute_names(for_matching_data) } }
    convert_results_for_view(results)
  end

  def convert_results_for_view(results)
    results.map do |result|
      if result[:match]
        result[:detail] = display_values(result[:detail])
      elsif result[:detail].present?
        result[:detail] = display_values(check_diffrent_attributes(result[:detail]))
      end
      result[:for_matching_data] = display_values(result[:for_matching_data]) if result[:for_matching_data].present?
      result
    end
  end

  def display_values(attributes)
    attributes.values.delete_if(&:blank?).unshift(model.code).join('|')
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
    }.map { |key, value| [key, value.to_s] }.to_h
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
    }.map { |key, value| [key, value.to_s] }.to_h
  end

  def check_diffrent_attributes(attributes)
    for_matching_datas = @for_matching_datas.select { |for_matching_data| attributes[:doc_no] == for_matching_data[:doc_no] }.map do |for_matching_data|
      convert_for_matching_data_attribute_names(for_matching_data)
    end
    for_matching_datas.each do |for_matching_data|
      next if attributes == for_matching_data
      attributes.keys.select { |key| attributes[key] != for_matching_data[key] }. each do |key|
        attributes[key] = '？' if attributes[key].blank?
        attributes[key] = "<span style=\"color:red;\">#{attributes[key]}</span>"
      end
    end
    attributes
  end
end
