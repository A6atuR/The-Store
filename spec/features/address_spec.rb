require 'features/features_spec_helper'
 
feature "Address" do
  let(:customer) { create(:customer) }
  let(:address) { create(:address, customer_id: customer.id) }
  let(:credit_card) { create(:credit_card) }
  let(:order) { customer.orders.first }
  
  before do
    login_as(customer, scope: :customer)
    order.update_attributes(address_id: address.id, credit_card_id: credit_card.id)
  end

  scenario "To buy a book Customer can enter address" do
    visit new_address_path
    within '#new_address' do
      fill_in 'address_address', with: Faker::Address.street_name
      fill_in 'address_city', with: Faker::Address.city
      fill_in 'address_zip_code', with: Faker::Address.zip_code
      fill_in 'address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t('addresses.submit')
    end
    # expect(page).not_to have_content I18n.t('orders.address')
    expect(page).to have_content I18n.t('orders.credit_card')
  end

  scenario "Customer can edit address before compliting this order" do
    visit edit_address_path(address)
    within '.edit_address' do
      fill_in 'address_address', with: Faker::Address.street_name
      fill_in 'address_city', with: Faker::Address.city
      fill_in 'address_zip_code', with: Faker::Address.zip_code
      fill_in 'address_phone', with: Faker::PhoneNumber.phone_number
      click_button I18n.t('addresses.submit')
    end
    expect(page).to have_content I18n.t('orders.confirm')
  end
end