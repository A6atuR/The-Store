require 'features/features_spec_helper'
 
feature "Category" do
  let(:customer) { create(:customer) }
  
  before do
    @order = create(:order)
    @book = create(:book)
    @category = create(:category)

    login_as(customer, scope: :customer)
  end
  
  scenario "Customer can view shop page" do
    visit books_path
    click_link I18n.t('links.shop')
    expect(page).not_to have_content I18n.t('books.submit')
    expect(page).to have_content I18n.t('links.shop')
    expect(page).to have_content I18n.t('categories.shop_by_categories')
  end

  scenario "Customer can navigate the site by categories" do
    visit categories_path
    click_link(@category.title)
    expect(page).to have_content I18n.t('categories.categories', category: @category.title)
    expect(page).to have_content I18n.t('categories.shop_by_categories')
  end
end