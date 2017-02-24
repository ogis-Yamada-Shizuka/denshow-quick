FactoryGirl.define do
  factory :for_matching_data do
    format_type 'PICTURE'
    document_no 'KP／PICTURE／AAA／R01／N99／BVSR／(D)／ｲ-6#2／A-N／A'
    model_code 'KP'
    doc_no 'AA10'
    doc_type_str 'PICTURE'
    sht 'AAA'
    rev 'R01'
    eo_chgno 'N99'
    chg_type_str 'BVSR'
    mcl '(D)'
    scp_for_smpl 'ｲ-6#2'
    scml 'A-N'
    revision 'A'
  end

  factory :fmd_same_attribute_as_detail, class: ForMatchingData do
    format_type 'TYPE1'
    sequence :document_no do |n|
      "A01／DOC-TEST-#{n}／GHI／S01／-／CHG1／BVSR／MC1／SCP／1LN／A"
    end
    model_code 'A01'
    sequence(:doc_no) { |n| "DOC-TEST-#{n}" }
    doc_type_str 'GHI'
    sht 'S01'
    rev '-'
    eo_chgno 'CHG1'
    chg_type_str 'BVSR'
    mcl 'MC1'
    scp_for_smpl 'SCP'
    scml '1LN'
    revision 'A'
  end
end
