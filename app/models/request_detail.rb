class RequestDetail < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :doc_type
  belongs_to :chg_type

  validates :sht, length: { maximum: 255 }
  validates :rev, length: { maximum: 255 }
  validates :eo_chgno, length: { maximum: 255 }
  validates :chg_type, length: { maximum: 255 }
  validates :mcl, length: { maximum: 255 }
  validates :scp_for_smpl, length: { maximum: 255 }
  validates :scml_ln, length: { maximum: 255 }
end
