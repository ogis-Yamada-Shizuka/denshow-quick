module RequestApplication::Matcher
  def compare_to_matching_datas
    @for_matching_datas = ForMatchingData.where(model_code: model.code).order(doc_no: :ASC)
    details.group(:doc_no).order(doc_no: :ASC).pluck(:doc_no).flat_map { |doc_no| compare_for_view doc_no }
  end

  private

  # TODO: メソッドの行数が長過ぎるので細かく切る
  def compare_for_view(doc_no)
    key = "#{model.code} #{doc_no}"
    results = []
    target_details = details.includes(:doc_type, :chg_type).where(doc_no: doc_no).to_a
    target_for_matching_datas = @for_matching_datas.select { |for_matching_data| doc_no == for_matching_data[:doc_no] }
    # 一致した detail と for_matching_data を詰めて対象の配列から削除する
    target_details.delete_if do |detail|
      match = false
      target_for_matching_datas.delete_if do |for_matching_data|
        if detail.compare_attributes == for_matching_data.compare_attributes
          results << { key: key, match: true, detail: display_values(detail.compare_attributes), for_matching_data: display_values(for_matching_data.compare_attributes), detail_id: detail.id }
          match = true
        end
      end
      match
    end
    # 一致しなかった detail と for_matching_data を詰める
    results.concat target_details.map { |detail| { key: key, match: false, detail: display_values(replace_diffrent_attribute_value(detail.compare_attributes, target_for_matching_datas)), detail_id: detail.id } }
    results.concat target_for_matching_datas.map { |for_matching_data| { key: key, match: false, for_matching_data: display_values(for_matching_data.compare_attributes) } }
  end

  def display_values(attributes)
    attributes.values.delete_if(&:blank?).unshift(model.code).join('|')
  end

  def replace_diffrent_attribute_value(attributes, unmatched_for_matching_datas)
    same_doc_no_for_matching_datas = unmatched_for_matching_datas.select { |for_matching_data| attributes[:doc_no] == for_matching_data[:doc_no] }.map(&:compare_attributes)
    same_doc_no_for_matching_datas.each do |for_matching_data|
      attributes.keys.select { |key| attributes[key] != for_matching_data[key] }.each do |key|
        attributes[key] = convert_to_display_value(attributes[key])
      end
    end
    attributes
  end

  # spanタグと？への文字置換を行う
  def convert_to_display_value(value)
    return value if value.include?('</span>')
    replaced_value = value.blank? ? '？' : value
    "<span style=\"color:red;\">#{replaced_value}</span>"
  end
end
