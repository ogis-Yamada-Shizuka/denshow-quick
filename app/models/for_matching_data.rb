class ForMatchingData < ActiveRecord::Base

  %i(format_type document_no model_code doc_type_str sht rev eo_chgno chg_type_str mcl scp_for_smpl scml revision).each do |attribute|
    validates attribute, length: { maximum: 255 }
  end

  validates :document_no, uniqueness: { scope: :revision }
end
