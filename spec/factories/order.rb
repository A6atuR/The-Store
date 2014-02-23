FactoryGirl.define do
  factory :order do
    total_price 200.0
    state "Ok"
    completed_at Time.now
    customer
    address
  end
end