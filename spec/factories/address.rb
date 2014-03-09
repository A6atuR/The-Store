FactoryGirl.define do
  factory :address do
    address Faker::Address.street_name
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country
  end

  factory :invalid_address, parent: :address do |f| 
    f.address nil 
  end
end