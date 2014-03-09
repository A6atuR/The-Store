require 'features/features_spec_helper'
 
feature "Book" do
  let(:customer) { create(:customer) }
  
  before do
    login_as(customer, scope: :customer)
    @book = create(:book)
  end
  
  scenario "Customer can view detailed information on a book" do
    visit categories_path
    click_link(@book.title)
    expect(page).to have_content @book.description
    expect(page).to have_content "Reviews"
    expect(page).not_to have_content 'Shop by Categories'
  end
end