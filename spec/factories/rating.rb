FactoryGirl.define do
  factory :rating do
    rating 1
    text "Some text"
    book
    customer
  end
end