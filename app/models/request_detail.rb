class RequestDetail < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :doc_type
  belongs_to :chg_type

  before_validation do
    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln vendor_code).each do |attribute|
      send(attribute).upcase! if send(attribute).present?
    end
  end

  INVALID_REGEX = %r([^0-9^A-Z^ｧ-ﾝﾞﾟ!-/`:-@≠\[-`{-~])

  %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
    validates attribute, length: { maximum: 255 }, format: { without: INVALID_REGEX }
  end

  validates :doc_type_id, presence: true
  validates :vendor_code, presence: true
  validates :vendor_code, length: { maximum: 255 }, format: { without: /[^0-9^A-Z]/ }
  validates :doc_no, presence: true
  validates :sht, presence: true
  validates :rev, presence: true

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
