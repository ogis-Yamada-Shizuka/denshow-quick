class AddVendorIdToRequestApplication < ActiveRecord::Migration
  def change
    add_column :request_applications, :vendor_id, :integer
  end
end
