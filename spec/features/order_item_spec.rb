require 'features/features_spec_helper'
 
feature "Order Item" do
  let(:customer) { create(:customer) }
  let(:book) { create(:book) }
  let(:order) { customer.orders.first }
  
  before do
    login_as(customer, scope: :customer)
    @order_item = create(:order_item, order_id: order.id, book_id: book.id)
  end
  
  scenario "Customer can put books into a shopping cart" do
    visit book_path(book)
    fill_in 'order_item_quantity', with: 2
    click_button("Add to Cart")
    expect(page).to have_content "Shopping Cart"
    expect(page).to have_content "Remove"
    expect(page).not_to have_content 'Add to Cart'
  end

  scenario "Customer can remove books from shopping cart before completing an order" do
    visit shopping_cart_path
    page.find(".link").click
    expect(page).to have_content "Shopping Cart"
    expect(page).not_to have_content 'Add to Cart'
  end
end