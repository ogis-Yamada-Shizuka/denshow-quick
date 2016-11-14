class AddHistoryNoToFlow < ActiveRecord::Migration
  def change
    add_column :flows, :history_no, :integer
  end
end
