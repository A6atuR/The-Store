class OrderItemsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  def create
    @order = current_customer.current_order
    @order_item = @order.order_items.create(order_item_params)
    redirect_to shopping_cart_path
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to shopping_cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
