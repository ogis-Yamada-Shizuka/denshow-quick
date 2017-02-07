class ForMatchingData < ActiveRecord::Base

  %i(format_type document_no model_code doc_no doc_type_str sht rev eo_chgno chg_type_str mcl scp_for_smpl scml revision).each do |attribute|
    validates attribute, length: { maximum: 255 }
  end

  validates :document_no, uniqueness: true

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
