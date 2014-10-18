require 'features/features_spec_helper'
 
feature "Credit Card" do
  let(:customer) { create(:customer) }
  
  before do
    login_as(customer, scope: :customer)
    @order = create(:order)
    @country = create(:country) 
    @billing_address = create(:address, customer_id: customer.id, country_id: @country.id)
    @shipping_address = create(:address, customer_id: customer.id, country_id: @country.id, address_type: 'shipping')
    @credit_card = create(:credit_card, customer_id: customer.id)
  end

  scenario "To buy a book Customer can enter credit card" do
    visit new_credit_card_path
    within '#new_credit_card' do
      fill_in 'credit_card_number', with: Faker::Business.credit_card_number
      fill_in 'credit_card_cvv', with: 1111
      select "December", :from => 'credit_card_expiration_date_2i'
      select "2018", :from => 'credit_card_expiration_date_1i'
      click_button I18n.t('credit_cards.submit')
    end
    expect(page).not_to have_content I18n.t('orders.credit_card')
    expect(page).to have_content I18n.t('orders.confirm')
  end

  scenario "Customer can edit credit_card before compliting this order" do
    visit edit_credit_card_path(@credit_card)
    within '.edit_credit_card' do
      fill_in 'credit_card_number', with: Faker::Business.credit_card_number
      fill_in 'credit_card_cvv', with: 2222
      select "December", :from => 'credit_card_expiration_date_2i'
      select 2016, :from => 'credit_card_expiration_date_1i'
      click_button I18n.t('credit_cards.submit')
    end
    expect(page).not_to have_content I18n.t('orders.credit_card')
    expect(page).to have_content I18n.t('orders.confirm')
  end
end