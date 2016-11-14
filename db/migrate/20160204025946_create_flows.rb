class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.references :request_application, index: true, foreign_key: true
      t.integer :order
      t.references :dept, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
