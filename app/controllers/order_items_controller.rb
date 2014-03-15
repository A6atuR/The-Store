class OrderItemsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @order = current_customer.current_order
    @order_item.order = @order
    redirect_to shopping_cart_path if @order_item.save
  end

  def destroy
    @order_item.destroy
    redirect_to shopping_cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end