FactoryGirl.define do
  factory :request_application do
    management_no 'AABB-01-ｱ'
    emargency false
    request_date Time.zone.now.to_date.beginning_of_month
    preferred_date Time.zone.now.to_date.end_of_month
    close false
  end
end
