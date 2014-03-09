require 'features/features_spec_helper'
 
feature "Credit Card" do
  let(:customer) { create(:customer) }
  let(:address) { create(:address) }
  let(:credit_card) { create(:credit_card) }
  let(:order) { customer.orders.first }
  
  before do
    login_as(customer, scope: :customer)
    order.update_attributes(address_id: address.id, credit_card_id: credit_card.id)
  end

  scenario "To buy a book Customer can enter credit card" do
    visit new_credit_card_path
    within '#new_credit_card' do
      fill_in 'credit_card_number', with: Faker::Business.credit_card_number
      fill_in 'credit_card_cvv', with: 111
      fill_in 'credit_card_expiration_month', with: "March"
      fill_in 'credit_card_expiration_year', with: 2018
      click_button('Save and Continue')
    end
    expect(page).not_to have_content 'CREDIT CARD'
    expect(page).to have_content 'CONFIRM'
  end

  scenario "Customer can edit credit_card before compliting this order" do
    visit edit_credit_card_path(credit_card)
    within '.edit_credit_card' do
      fill_in 'credit_card_number', with: Faker::Business.credit_card_number
      fill_in 'credit_card_cvv', with: 2222
      fill_in 'credit_card_expiration_month', with: "March"
      fill_in 'credit_card_expiration_year', with: 2015
      click_button('Save and Continue')
    end
    expect(page).not_to have_content 'CREDIT CARD'
    expect(page).to have_content 'CONFIRM'
  end
end