class OrdersController < ApplicationController
  authorize_resource
  
  def index
    @orders = current_customer.orders
  end

  def shopping_cart
    @order = current_customer.current_order
  end

  def update
    @order = current_customer.current_order
    @order.update_attributes(status: "order", total_price: @order.total_price, completed_at: Time.now, state: 'in_queue')
    current_customer.orders.create(status: "shopping_cart", state: 'in_progress')
    redirect_to orders_path
  end

  def confirm
    @order = Order.find(params[:order_id])
    @address = @order.address
    @credit_card = @order.credit_card
  end

  def show
    @order = Order.find(params[:id])
  end
end
