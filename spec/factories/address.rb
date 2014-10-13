FactoryGirl.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    address Faker::Address.street_name
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country
    customer
    address_type 'billing'
    shipping false
  end

  factory :invalid_address, parent: :address do |f| 
    f.address nil 
  end
end