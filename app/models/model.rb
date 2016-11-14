class Model < ActiveRecord::Base
  validates :code, length: { is: 3 }, format: { with: /[A-Za-z0-9]/ }
end
