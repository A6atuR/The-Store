FactoryGirl.define do
  factory :order do
    total_price 100
    state "in_progress"
    completed_at nil
    customer
    credit_card
    delivery
  end
end