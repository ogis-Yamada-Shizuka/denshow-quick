class Project < ActiveRecord::Base
  has_many :request_applications
end
