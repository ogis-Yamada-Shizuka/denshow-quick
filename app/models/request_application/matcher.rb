module RequestApplication::Matcher
  def compare_to_matching_datas
    {}.tap do |result|
      details.group(:doc_no).order(doc_no: :ASC).pluck(:doc_no).each { |doc_no| result["#{model.code} #{doc_no}"] = compare(doc_no) }
    end
  end

  private

  def compare(doc_no)
    @results = { matched: [], unmatched_details: [], unmatched_for_matching_datas: [] }
    target_details(doc_no).each do |detail|
      unless target_for_matching_datas(doc_no).map { |fmd| match?(detail, fmd) }.any?
        @results[:unmatched_details] << { detail: detail, unmatched_attributes: unmatched_attributes(detail, unmatched_for_matching_datas) }
      end
    end
    remove_unnecessary_unmatched_for_matching_datas
    @results
  end

  def target_details(doc_no)
    details.includes(:doc_type, :chg_type).where(doc_no: doc_no)
  end

  def target_for_matching_datas(doc_no)
    ForMatchingData.where(model_code: model.code, doc_no: doc_no).order(doc_no: :ASC)
  end

  def match?(detail, for_matching_data)
    if detail.compare_attributes == for_matching_data.compare_attributes
      @results[:matched] << { detail: detail, for_matching_data: for_matching_data }
      true
    else
      @results[:unmatched_for_matching_datas] << { for_matching_data: for_matching_data }
      false
    end
  end

  def unmatched_for_matching_datas
    @results[:unmatched_for_matching_datas].map { |h| h[:for_matching_data] }.select do |fmd|
      @results[:matched].all? { |matched| matched[:for_matching_data] != fmd }
    end
  end

  def unmatched_attributes(detail, unmatched_for_matching_datas)
    [].tap do |unmatched|
      attributes = detail.compare_attributes
      unmatched_for_matching_datas.select { |fmd| attributes[:doc_no] == fmd[:doc_no] }.map(&:compare_attributes).each do |fmd|
        attributes.keys.select { |key| attributes[key] != fmd[key] }.each { |key| unmatched << key }
      end
    end.uniq
  end

  def remove_unnecessary_unmatched_for_matching_datas
    @results[:unmatched_for_matching_datas].uniq!
    @results[:unmatched_for_matching_datas].delete_if do |h|
      for_matching_data_is_already_matched?(h[:for_matching_data])
    end
  end

  def for_matching_data_is_already_matched?(for_matching_data)
    @results[:matched].any? { |matched| matched[:for_matching_data] == for_matching_data }
  end
end
