class AddModelIdToRequestApplication < ActiveRecord::Migration
  def change
    add_column :request_applications, :model_id, :integer
  end
end
