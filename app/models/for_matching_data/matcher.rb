module ForMatchingData::Matcher
  def compare_attributes
    {
      doc_no: doc_no,
      doc_type: doc_type_str,
      sht: sht,
      rev: revision,
      eo_chgno: eo_chgno,
      chg_type: chg_type_str,
      mcl: mcl,
      scp_for_smpl: scp_for_smpl,
      scml_ln: scml
    }.map { |key, value| [key, value.to_s] }.to_h
  end
end
