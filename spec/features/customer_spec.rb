require 'features/features_spec_helper'
 
feature "Registration" do
  let(:customer) { create(:customer) }

  before { @book = create(:book) }

  scenario "Visitor can sign up successfully as customer" do
    visit new_customer_registration_path
    within '#new_customer' do
      fill_in 'customer_email', with: Faker::Internet.email
      fill_in 'customer_password', with: '12345678'
      fill_in 'customer_password_confirmation', with: '12345678'
      click_button('Sign up')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Sign out'
  end

  scenario "Visitor can sign in successfully as customer" do
    visit new_customer_session_path
    within '#new_customer' do
      fill_in 'customer_email', with: customer.email
      fill_in 'customer_password', with: customer.password
      click_button('Sign in')
    end
    expect(page).not_to have_content 'Sign in'
    expect(page).to have_content 'Sign out'
  end

  scenario "Customer can sign out successfully" do
    login_as(customer, scope: :customer)
    visit books_path
    click_link("Sign out")
    expect(page).not_to have_content 'Sign out'
    expect(page).to have_content 'Sign up'
    expect(page).to have_content 'Sign in'
  end

  scenario "Customer can change his email or password" do
    login_as(customer, scope: :customer)
    visit edit_customer_registration_path
    within '#edit_customer' do
      fill_in 'customer_email', with: customer.email
      fill_in 'customer_password', with: "1234567890"
      fill_in 'customer_password_confirmation', with: "1234567890"
      fill_in 'customer_current_password', with: customer.password
      click_button('Save')
    end
    expect(page).not_to have_content 'Remove Account'
    expect(page).to have_content @book.title
    expect(page).to have_content @book.description
    expect(page).to have_content @book.price
  end
end