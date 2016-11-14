class AddProjectIdToRequestApplication < ActiveRecord::Migration
  def change
    add_column :request_applications, :project_id, :integer
  end
end
