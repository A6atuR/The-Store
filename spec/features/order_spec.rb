require 'features/features_spec_helper'
 
feature "Order" do
  let(:customer) { create(:customer) }
  
  before do
    login_as(customer, scope: :customer)
    @book = create(:book)
    @order = create(:order, state: 'in_queue', customer_id: customer.id)
  end
  
  scenario "Customer can view a history of all of his past orders" do
    visit books_path
    click_link('Orders')
    expect(page).to have_content "IN PROGRESS"
    expect(page).to have_content "IN QUEUE"
    expect(page).to have_content 'IN DELIVERY'
    expect(page).to have_content 'DELIVERED'
  end

  scenario "Customer can check the status of his recent orders" do
    visit orders_path
    page.find(".link").click
    expect(page).to have_content "Order #{@order.id}"
    expect(page).to have_content @order.state
    expect(page).to have_content 'Back to orders'
    expect(page).not_to have_content "IN PROGRESS"
    expect(page).not_to have_content "IN QUEUE"
    expect(page).not_to have_content 'IN DELIVERY'
    expect(page).not_to have_content 'DELIVERED'
  end

  scenario "Customer can view his shopping cart" do
    visit books_path
    click_link('Shopping Cart')
    expect(page).to have_content "Image"
    expect(page).to have_content "Book title"
    expect(page).to have_content 'Price'
    expect(page).to have_content 'Quantity'
    expect(page).to have_content 'Total'
    expect(page).to have_content 'SUBTOTAL'
  end
end