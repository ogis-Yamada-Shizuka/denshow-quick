class DropVendors < ActiveRecord::Migration
  def up
    drop_table :vendors
  end

  def down
    create_table :vendors do |t|
      t.string :code
      t.string :name
      t.timestamps null: false
    end
  end
end
