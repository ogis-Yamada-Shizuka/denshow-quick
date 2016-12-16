class RemoveVendorIdColumnToRequestDetails < ActiveRecord::Migration
  def up
    remove_foreign_key :request_details, :vendor
    remove_reference :request_details, :vendor, index: true
  end

  def down
    add_reference :request_details, :vendor, index: true, foreign_key: true
  end
end
