FactoryGirl.define do
  factory :order_item do
    price 100.0
    quantity 2
    book
    order
  end
end