FactoryGirl.define do
  factory :request_detail do
    doc_no 'AABB-01-ｱ'
    sht 'AAA'
    rev 'R01'
    eo_chgno 'N99'
    mcl '(D)'
    scp_for_smpl 'ｲ-6#2'
    scml_ln 'A-N'
    vendor_code 'A0001'
  end

  factory :request_detail_same_attribute_as_fmd, class: RequestDetail do
    association :doc_type
    association :chg_type

    sequence :doc_no do |n|
      "DOC-TEST-#{n}"
    end
    sht 'S01'
    rev 'A'
    eo_chgno 'CHG1'
    mcl 'MC1'
    scp_for_smpl 'SCP'
    scml_ln '1LN'
    vendor_code 'A0001'
  end
end
