FactoryGirl.define do
  factory :credit_card do
    number 123456789012
    cvv 123
    expiration_month "March"
    expiration_year 2015
    customer
  end
end