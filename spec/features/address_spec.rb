require 'features/features_spec_helper'
 
feature "Address" do
  let(:customer) { create(:customer) }
  
  before do
    login_as(customer, scope: :customer)
    @order = create(:order)
    @country = create(:country) 
    @billing_address = create(:address, customer_id: customer.id, country_id: @country.id)
    @shipping_address = create(:address, customer_id: customer.id, country_id: @country.id, address_type: 'shipping')
    @credit_card = create(:credit_card, customer_id: customer.id)
  end

  scenario "To buy a book Customer can enter address" do
    visit new_address_path
    within '#new_address' do
      fill_in 'address_first_name', with: Faker::Name.first_name
      fill_in 'address_last_name', with: Faker::Name.last_name
      fill_in 'address_address', with: Faker::Address.street_name
      fill_in 'address_city', with: Faker::Address.city
      select "Ukraine", :from => 'address_country_id'
      fill_in 'address_zip_code', with: Faker::Address.zip_code
      fill_in 'address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t('addresses.submit')
    end
    expect(page).to have_content 'Billing address has been successfully created'
  end

  scenario "Customer can edit address before compliting this order" do
    visit edit_address_path(@billing_address)
    within '.edit_address' do
      fill_in 'address_first_name', with: Faker::Name.first_name
      fill_in 'address_last_name', with: Faker::Name.last_name
      fill_in 'address_address', with: Faker::Address.street_name
      fill_in 'address_city', with: Faker::Address.city
      select "Ukraine", :from => 'address_country_id'
      fill_in 'address_zip_code', with: Faker::Address.zip_code
      fill_in 'address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t('addresses.submit')
    end
    expect(page).to have_content 'Address has been successfully updated'
  end
end