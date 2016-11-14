class CreateRequestApplications < ActiveRecord::Migration
  def change
    create_table :request_applications do |t|
      t.string :management_no
      t.boolean :emargency
      t.string :filename
      t.date :request_date
      t.date :preferred_date
      t.boolean :close

      t.timestamps null: false
    end
  end
end
