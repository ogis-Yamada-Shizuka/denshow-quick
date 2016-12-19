class AddDocNoToForMatchingData < ActiveRecord::Migration
  def change
    add_column :for_matching_data, :doc_no, :string
  end
end
