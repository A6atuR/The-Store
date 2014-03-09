FactoryGirl.define do
  factory :order do
    total_price 100
    status "shopping_cart"
    state "in_progress"
    completed_at nil
    customer
    address
    credit_card
  end
end