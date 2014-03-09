FactoryGirl.define do
  factory :credit_card do
    number Faker::Business.credit_card_number
    cvv 123
    expiration_month "March"
    expiration_year 2015
    customer
  end

  factory :invalid_credit_card, parent: :credit_card do |f| 
    f.number nil 
  end
end