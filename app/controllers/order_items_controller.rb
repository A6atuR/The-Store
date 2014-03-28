class OrderItemsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @order = current_customer.current_order
    @order_item.order = @order
    if @order_item.save
      redirect_to shopping_cart_path, alert: "Book has been successfully added to shopping cart"
    else
      redirect_to root_url, alert: "Incorrect data"
    end
  end

  def destroy
    @order_item.destroy
    redirect_to shopping_cart_path, alert: "Book has been successfully removed from shopping cart"
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end