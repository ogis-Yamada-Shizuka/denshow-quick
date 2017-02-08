module RequestApplication::MatcherExportCsv

  HEADER = [
    '種類',
    'ドキュメント番号',
    'リビジョン',
    'SHEET枚数',
    'ステータス',
    '配付区分',
    'CONTROL COPY NO',
    '配付先',
    '配付要求課（資材）',
    'REL日',
    '配付指示日',
    '受領日',
    '返却日',
    '配付状態',
    'ドキュメント名称',
    '参考情報',
    'ドキュメント・サイズ（原寸）',
    'サイズ、枚数（混在パターン）',
    '印刷縮尺',
    '部数',
    '配付方式',
    'サブコンコード（設計分担）',
    'サブコンコード（製造分担）',
    '複製用W/O',
    '点検承認PKG番号',
    '発行条件',
    '配付備考',
    '配付トリガー',
    '配付情報確定日',
    'プラングループ',
    'セキュリティコード',
    'OID1',
    'OID2'
  ].freeze

  ROW_ATTRIBUTES = {
    '種類' => :format_type,
    'ドキュメント番号' => :document_no,
    'リビジョン' => :revision,
    '配付先' => :vendor_code
  }.freeze

  def export_matching_result_csv
    CSV.generate(headers: HEADER, write_headers: true) do |csv|
      matched_rows.each { |row| csv << row }
    end.encode(Encoding::SJIS)
  end

  private

  def matched_rows
    matched_values.map do |value|
      HEADER.map do |name|
        value[ROW_ATTRIBUTES[name]] if ROW_ATTRIBUTES.key?(name)
      end
    end
  end

  def matched_values
    target_for_matching_datas = ForMatchingData.where(model_code: model.code).order(doc_no: :ASC).to_a
    details.includes(:doc_type, :chg_type).order(doc_no: :ASC).map do |detail|
      values = {}
      target_for_matching_datas.delete_if do |for_matching_data|
        if detail.compare_attributes == for_matching_data.compare_attributes
          set_values(values, detail, for_matching_data)
          true
        end
      end
      values.present? ? values : nil
    end.compact
  end

  def set_values(values, detail, for_matching_data)
    values[:format_type] = for_matching_data.format_type
    values[:document_no] = for_matching_data.document_no
    values[:revision] = for_matching_data.revision
    values[:vendor_code] = detail.vendor_code
  end
end
