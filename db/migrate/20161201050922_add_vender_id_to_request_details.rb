class AddVenderIdToRequestDetails < ActiveRecord::Migration
  def change
    add_reference :request_details, :vendor, index: true, foreign_key: true
  end
end
