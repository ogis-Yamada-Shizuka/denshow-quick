module Section::ImportCsv
  require 'csv'
  extend ActiveSupport::Concern

  class_methods do
    def import(file)
      CSV.foreach(file.path, encoding: 'SJIS:UTF-8', headers: true) do |row|
        section = find_or_initialize_by(id: row['id'])
        section.attributes = row.to_hash.slice(*column_names)
        section.save!
      end
    end
  end
end
