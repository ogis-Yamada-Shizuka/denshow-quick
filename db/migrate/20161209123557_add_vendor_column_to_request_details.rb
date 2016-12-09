class AddVendorColumnToRequestDetails < ActiveRecord::Migration
  def change
    add_column :request_details, :vendor_code, :string
  end
end
