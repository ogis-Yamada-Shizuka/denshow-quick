class RequestDetail < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :doc_type
  belongs_to :chg_type
  belongs_to :vendor

  before_validation do
    %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
      send(attribute).upcase!
    end
  end

  INVALID_REGEX = /\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々]|[Ａ-Ｚ]|[０-９]/

  # TODO: rspecセットアップ後にvalidateのテストコードを書くこと
  %i(doc_no sht rev eo_chgno mcl scp_for_smpl scml_ln).each do |attribute|
    validates attribute, length: { maximum: 255 }, format: { without: INVALID_REGEX }
  end
end
