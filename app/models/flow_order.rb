class FlowOrder < ActiveRecord::Base
  belongs_to :dept
  scope :order_list, -> { all.order(:order) }
end
