class CreateFlowOrders < ActiveRecord::Migration
  def change
    create_table :flow_orders do |t|
      t.integer :order
      t.boolean :project_flg
      t.references :dept, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
