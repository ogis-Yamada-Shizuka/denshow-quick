class AddFirstToRevertPermissionToFlowOrder < ActiveRecord::Migration
  def change
    add_column :flow_orders, :first_to_revert_permission, :boolean
  end
end
