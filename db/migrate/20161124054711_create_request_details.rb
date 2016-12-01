class CreateRequestDetails < ActiveRecord::Migration
  def change
    create_table :request_details do |t|
      t.references :request_application, index: true, foreign_key: true
      t.string :doc_no
      t.string :doc_type
      t.string :sht
      t.string :rev
      t.string :eo_chgno
      t.string :chg_type
      t.string :mcl
      t.string :scp_for_smpl
      t.string :scml_ln
      t.timestamps null: false
    end
  end
end
