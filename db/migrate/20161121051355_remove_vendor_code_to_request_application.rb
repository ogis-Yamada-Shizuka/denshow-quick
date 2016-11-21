class RemoveVendorCodeToRequestApplication < ActiveRecord::Migration
  def up
    remove_column :request_applications, :vendor_id
  end

  def down
    add_column :request_applications, :vendor_id, :integer
  end
end
