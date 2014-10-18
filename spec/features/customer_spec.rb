require 'features/features_spec_helper'
 
feature "Registration" do
  let(:customer) { create(:customer) }

  before do
    @order = create(:order)
    @book = create(:book)
  end

  scenario "Visitor can sign up successfully as customer" do
    visit new_customer_registration_path
    within '#new_customer' do
      fill_in 'customer_email', with: Faker::Internet.email
      fill_in 'customer_password', with: '12345678'
      fill_in 'customer_password_confirmation', with: '12345678'
      click_button I18n.t('devise.sign_up')
    end
    expect(page).not_to have_content I18n.t('devise.sign_up')
    expect(page).to have_content I18n.t('links.sign_out')
  end

  scenario "Visitor can sign in successfully as customer" do
    visit new_customer_session_path
    within '#new_customer' do
      fill_in 'customer_email', with: customer.email
      fill_in 'customer_password', with: customer.password
      click_button I18n.t('devise.sign_in')
    end
    expect(page).not_to have_content I18n.t('devise.sign_in')
    expect(page).to have_content I18n.t('links.sign_out')
  end

  scenario "Customer can sign out successfully" do
    login_as(customer, scope: :customer)
    visit books_path
    click_link I18n.t('links.sign_out')
    expect(page).not_to have_content I18n.t('links.sign_out')
    expect(page).to have_content I18n.t('devise.sign_in')
    expect(page).to have_content I18n.t('devise.sign_up')
  end

  scenario "Customer can change his email" do
    login_as(customer, scope: :customer)
    visit edit_account_customers_path
    within '.email' do
      fill_in 'customer_email', with: 'test@gmail.com'
      click_button 'Save'
    end
    expect(page).to have_content 'Email has been successfully updated'
  end
end