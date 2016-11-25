class RequestDetail < ActiveRecord::Base
  belongs_to :request_application

  validates :doc_no, length: { maximum: 255 }
  validates :doc_type, length: { maximum: 255 }
  validates :sht, length: { maximum: 255 }
  validates :rev, length: { maximum: 255 }
  validates :eo_chgno, length: { maximum: 255 }
  validates :chg_type, length: { maximum: 255 }
  validates :mcl, length: { maximum: 255 }
  validates :scp_for_smpl, length: { maximum: 255 }
  validates :scml_ln, length: { maximum: 255 }
end
