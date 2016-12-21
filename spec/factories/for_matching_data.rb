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
end
