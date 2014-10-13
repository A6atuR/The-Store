class OrdersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_customer!, only: [:index, :update, :confirm, :complete, :show, :new_delivery, :edit_delivery, :create_delivery, :update_delivery]
  
  def index
    @orders = current_customer.orders
  end

  def shopping_cart
    if params[:search]
      @coupon = Coupon.where(code: params[:search].to_i, used: false).first
      if @coupon
        @coupon.update_attributes(used: true, order_id: @order.id)
        @order.update_total_price
        flash[:success] = "You have successfully used your discount coupon"
        redirect_to shopping_cart_path
      else
        flash[:error] = "Incorrect coupon code"
        redirect_to shopping_cart_path
      end
    end
  end

  def update
    @order.update_attributes(completed_at: Time.now, customer_id: current_customer.id)
    @order.checkout
    session[:order_id] = nil
    flash[:success] = "Order has been successfully created"
    redirect_to order_complete_path(@order)
  end

  def confirm
    @billing_address = current_customer.addresses.where(address_type: "billing").last
    @shipping_address = current_customer.addresses.where(address_type: "shipping").last
    @credit_card = current_customer.credit_cards.last
    @delivery = @order.delivery
  end

  def complete
    @order = Order.find(params[:order_id])
    @billing_address = @order.addresses.where(address_type: "billing").last
    @shipping_address = @order.addresses.where(address_type: "shipping").last
    @delivery = @order.delivery
    @credit_card = @order.credit_card
  end

  def show
    @order = Order.find(params[:id])
  end

  def empty_cart
    @order.order_items.destroy_all
    flash[:success] = "All books have been successfully removed from shopping cart"
    redirect_to shopping_cart_path
  end

  def new_delivery
    @deliveries = Delivery.all
  end

  def edit_delivery
    @deliveries = Delivery.all
  end

  def create_delivery
    @order.update(order_params)
    flash[:success] = "Delivery has been successfully added to your order"
    redirect_to new_credit_card_path
  end

  def update_delivery
    @order.update(order_params)
    flash[:success] = "Delivery has been successfully updated"
    redirect_to order_confirm_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id)
  end
end

