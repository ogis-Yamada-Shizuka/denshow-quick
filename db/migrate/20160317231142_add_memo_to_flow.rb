class AddMemoToFlow < ActiveRecord::Migration
  def change
    add_column :flows, :memo, :text
  end
end
