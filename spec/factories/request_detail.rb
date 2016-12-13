FactoryGirl.define do
  factory :request_detail, class: RequestDetail do
    doc_no 'AABB-01-ｱ'
    sht 'AAA'
    rev 'R01'
    eo_chgno 'N99'
    mcl '(D)'
    scp_for_smpl 'ｲ-6#2'
    scml_ln 'A-N'
    vendor_code 'A0001'
  end
end
