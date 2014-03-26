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
    click_link I18n.t('links.orders')
    expect(page).to have_content I18n.t('orders.in_progress')
    expect(page).to have_content I18n.t('orders.in_queue')
    expect(page).to have_content I18n.t('orders.in_delivery')
    expect(page).to have_content I18n.t('orders.delivered')
  end

  scenario "Customer can check the status of his recent orders" do
    visit orders_path
    page.find(".link").click
    expect(page).to have_content I18n.t('orders.name', order: @order.id)
    expect(page).to have_content @order.state
    expect(page).to have_content I18n.t('orders.back_to_orders')
    expect(page).not_to have_content I18n.t('orders.in_progress')
    expect(page).not_to have_content I18n.t('orders.in_queue')
    expect(page).not_to have_content I18n.t('orders.in_delivery')
    expect(page).not_to have_content I18n.t('orders.delivered')
  end

  scenario "Customer can view his shopping cart" do
    visit books_path
    click_link I18n.t('links.shopping_cart')
    expect(page).to have_content I18n.t('order_items.image')
    expect(page).to have_content I18n.t('order_items.book')
    expect(page).to have_content I18n.t('order_items.book_price')
    expect(page).to have_content I18n.t('order_items.quantity')
    expect(page).to have_content I18n.t('order_items.total')
    expect(page).to have_content I18n.t('orders.subtotal', order: @order.total_price)
  end
end