require 'features/features_spec_helper'
 
feature "Category" do
  let(:customer) { create(:customer) }
  
  before do
    @book = create(:book)
    @category = create(:category)

    login_as(customer, scope: :customer)
  end
  
  scenario "Customer can view shop page" do
    visit books_path
    click_link("Shop")
    expect(page).not_to have_content "Add to Cart"
    expect(page).to have_content 'Shop'
    expect(page).to have_content 'Shop by Categories'
  end

  scenario "Customer can navigate the site by categories" do
    visit categories_path
    click_link(@category.title)
    expect(page).to have_content "Categories - #{@category.title}"
    expect(page).to have_content 'Shop by Categories'
  end
end