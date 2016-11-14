class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.references :flow, index: true, foreign_key: true
      t.datetime :in_date
      t.datetime :out_date

      t.timestamps null: false
    end
  end
end
