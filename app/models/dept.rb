class Dept < ActiveRecord::Base
  scope :projects, -> { where(project: true) }
  scope :departments, -> { where(project: false) }

  validates :name, uniqueness: true, presence: true
end
