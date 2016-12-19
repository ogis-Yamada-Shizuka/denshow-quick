FactoryGirl.define do
  factory :flow_order do
    order 1
    project_flg false
    reject_permission false
    first_to_revert_permission false
  end
end
