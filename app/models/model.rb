class Model < ActiveRecord::Base
  validates :code, format: { with: /[A-Za-z0-9]/ }

  # CSV Upload
  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, encoding: 'SJIS:UTF-8', headers: true) do |row|
      model = find_by_id(row['id']) || new
      model.attributes = row.to_hash.slice(*column_names)
      model.save!
    end
  end
end
