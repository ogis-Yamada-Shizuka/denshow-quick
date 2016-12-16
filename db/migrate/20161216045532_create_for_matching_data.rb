class CreateForMatchingData < ActiveRecord::Migration
  def change
    create_table :for_matching_data do |t|
      t.string :format_type
      t.string :document_no
      t.string :model_code
      t.string :doc_type_str
      t.string :sht
      t.string :rev
      t.string :eo_chgno
      t.string :chg_type_str
      t.string :mcl
      t.string :scp_for_smpl
      t.string :scml
      t.string :revision
      t.timestamps null: false
    end
  end
end
