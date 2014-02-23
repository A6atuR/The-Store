FactoryGirl.define do
  factory :book do
    title "Some book"
    description "Some text"
    price 100
    in_stock 20
    author
  end
end