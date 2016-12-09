class ModifyChgTypeReferenceFromRequestDetails < ActiveRecord::Migration
  def up
    remove_foreign_key :request_details, :chg_type
    remove_reference :request_details, :chg_type, index: true
    add_column :request_details, :chg_type_id, :integer
    add_index :request_details, :chg_type_id
  end

  def down
    remove_index :request_details, :chg_type_id
    remove_column :request_details, :chg_type_id, :integer
    add_reference :request_details, :chg_type, index: true, foreign_key: true
  end
end
