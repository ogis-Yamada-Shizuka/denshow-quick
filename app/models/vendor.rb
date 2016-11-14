class Vendor < ActiveRecord::Base
  validates :code, uniqueness: true, presence: true, length: { in: 4..6 }, format: { with: /[A-Za-z0-9]/ }
  validates :name, uniqueness: true, presence: true
end
