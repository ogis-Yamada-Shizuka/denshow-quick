class AddSectionIdToRequestApplication < ActiveRecord::Migration
  def change
    add_column :request_applications, :section_id, :integer
  end
end
