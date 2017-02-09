module RequestDetail::Matcher
  def compare_attributes
    {
      doc_no: doc_no,
      doc_type: doc_type.name,
      sht: sht,
      rev: rev,
      eo_chgno: eo_chgno,
      chg_type: chg_type&.name,
      mcl: mcl,
      scp_for_smpl: scp_for_smpl,
      scml_ln: scml_ln
    }.map { |key, value| [key, value.to_s] }.to_h
  end
end
