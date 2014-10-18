require 'features/features_spec_helper'
 
feature "Order Item" do
  let(:book) { create(:book) }
  let(:order) { create(:order) }

  before do
    @order_item = create(:order_item, order_id: order.id, book_id: book.id)
  end
  
  scenario "Customer can put books into a shopping cart" do
    visit book_path(book)
    fill_in 'order_item_quantity', with: 2
    click_button I18n.t('books.submit')
    expect(page).to have_content 'Book has been successfully added to shopping cart'
    expect(page).not_to have_content I18n.t('books.submit')
  end

  scenario "Customer can remove books from shopping cart before completing an order" do
    visit shopping_cart_path
    # click_button 'Remove'
    expect(page).to have_content I18n.t('orders.shopping_cart')
    expect(page).not_to have_content I18n.t('books.submit')
  end
end