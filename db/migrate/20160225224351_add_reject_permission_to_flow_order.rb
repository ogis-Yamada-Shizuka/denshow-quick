class AddRejectPermissionToFlowOrder < ActiveRecord::Migration
  def change
    add_column :flow_orders, :reject_permission, :boolean
  end
end
