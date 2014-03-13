class RatingsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create]

  def create
    @book = Book.find(params[:book_id])
    @books = Book.all
    @order = current_customer.current_order
    @order_item = @order.order_items.new
    @rating = current_customer.ratings.new(rating_params)
    if @rating.save
      redirect_to book_path(@book)
    else
      render 'books/index'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :text, :book_id)
  end
end
