class AddVendorColumnToRequestDetails < ActiveRecord::Migration
  def change
    add_column :request_details, :vendor, :string
  end
end
