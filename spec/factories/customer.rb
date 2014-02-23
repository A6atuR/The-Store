FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :customer do
    email { FactoryGirl.generate(:email) }
    password "12345678"
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end
end