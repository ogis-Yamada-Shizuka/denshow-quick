class ChangeChgAndDocTypeColumnToRequestDetails < ActiveRecord::Migration
  def change
    remove_column :request_details, :doc_type, :string
    remove_column :request_details, :chg_type, :string
    add_reference :request_details, :doc_type, index: true, foreign_key: true
    add_reference :request_details, :chg_type, index: true, foreign_key: true
  end
end
