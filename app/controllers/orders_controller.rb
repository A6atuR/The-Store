class OrdersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @orders = current_customer.orders
  end

  def shopping_cart
    @order = current_customer.current_order
  end

  def update
    @order = current_customer.current_order
    @order.update_attributes(total_price: @order.total_price, completed_at: Time.now)
    @order.checkout
    current_customer.orders.create(state: 'in_progress')
    redirect_to orders_path, alert: "Order has been successfully created"
  end

  def confirm
    @order = Order.find(params[:order_id])
    @address = @order.address
    @credit_card = @order.credit_card
  end

  def show
  end
end