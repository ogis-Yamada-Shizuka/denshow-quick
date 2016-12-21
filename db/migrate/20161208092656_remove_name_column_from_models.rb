class RemoveNameColumnFromModels < ActiveRecord::Migration
  def change
    remove_column :models, :name, :string
  end
end
