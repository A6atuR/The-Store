class OrdersController < ApplicationController
  def index
    @in_progress = current_customer.orders.find_by state: "in_progress"
    @in_queue = current_customer.orders.where state: "in_queue"
    @in_delivery = current_customer.orders.where state: "in_delivery"
    @delivered = current_customer.orders.where state: "delivered"
  end

  def shopping_cart
    @order = current_customer.orders.where(status: "shopping_cart").first
  end

  def update
    @order = current_customer.orders.where(status: "shopping_cart").first
    @order.update_attributes(status: "order", total_price: @order.total_price, completed_at: Time.now, state: 'in_queue')
    current_customer.orders.create(status: "shopping_cart", state: 'in_progress')
    redirect_to orders_path
  end

  def confirm
    @order = Order.find(params[:order_id])
  end

  def show
    @order = Order.find(params[:id])
  end
end
