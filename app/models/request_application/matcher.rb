module RequestApplication::Matcher
  # TODO: sp-03のwish終わり次第突合せ処理のテストコードを書く
  def compare_to_matching_datas
    @for_matching_datas = ForMatchingData.where(model_code: model.code).order(doc_no: :ASC)
    details.group(:doc_no).order(doc_no: :ASC).pluck(:doc_no).flat_map { |detail| compare_to detail }
  end

  private

  # TODO: 処理の確認取れてからリファクタする。
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
          results << { key: key, match: true, detail: detail_values_for_display(detail), for_matching_data: for_matching_data.document_no }
          match = true
        end
      end
      match
    end
    # 一致しなかった detail と for_matching_data を詰める
    results.concat target_details.map { |detail| { key: key, match: false, detail: detail_values_for_display(detail) } }
    results.concat target_for_matching_datas.map { |for_matching_data| { key: key, match: false, for_matching_data: for_matching_data.document_no } }
    results
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
end
