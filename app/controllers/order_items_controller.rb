class OrderItemsController < ApplicationController
  def create
    @order = current_customer.orders.find_by status: "shopping_cart"
    @order_item = @order.order_items.create(order_item_params)

    redirect_to '/shopping_cart'
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
 
    redirect_to '/shopping_cart'
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
