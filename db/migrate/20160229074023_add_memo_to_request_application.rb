class AddMemoToRequestApplication < ActiveRecord::Migration
  def change
    add_column :request_applications, :memo, :text
  end
end
