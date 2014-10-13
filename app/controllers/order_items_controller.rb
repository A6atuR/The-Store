class OrderItemsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @book = @order_item.book
    @order_item = @order.add_book(@order_item.book_id, params[:order_item], params[:order_item][:quantity])
    if @order_item.save
      flash[:success] = "Book has been successfully added to shopping cart"
      redirect_to shopping_cart_path
    else
      render 'books/show'
    end
  end

  def update
    if @order_item.update(order_item_params)
      flash[:success] = "Quantity has been successfully updated"
      redirect_to shopping_cart_path
    else
      flash[:error] = "Incorrect quantity"
      render 'orders/shopping_cart'
    end 
  end

  def destroy
    @order_item.destroy
    flash[:success] = "Book has been successfully removed from shopping cart"
    redirect_to shopping_cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :price)
  end
end