FactoryGirl.define do
  factory :book do
    title { Faker::Name.title }
    description "Some text"
    price 100.0
    in_stock 20
  end
end