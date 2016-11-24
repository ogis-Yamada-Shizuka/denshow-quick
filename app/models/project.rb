class Project < ActiveRecord::Base
  has_many :request_applications

  validates :name, length: { maximum: 255 }
end
