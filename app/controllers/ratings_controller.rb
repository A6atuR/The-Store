class RatingsController < ApplicationController
  load_and_authorize_resource

  def create
    @book = Book.find(params[:book_id])
    @books = Book.all
    @order = current_customer.current_order
    @order_item = @order.order_items.new
    @rating.customer = current_customer
    if @rating.save
      redirect_to book_path(@book), alert: "Rating successfully created and waiting for review"
    else
      redirect_to root_url, alert: "Incorrect data"
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :text, :book_id)
  end
end
