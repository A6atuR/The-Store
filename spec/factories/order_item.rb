FactoryGirl.define do
  factory :order_item do
    price 100
    quantity 4
    book
    order
  end

  factory :order_item_2, parent: :order_item do |f| 
    f.quantity 2 
  end
end