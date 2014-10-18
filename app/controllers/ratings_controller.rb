class RatingsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_customer!

  def new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    @books = Book.all
    @order_item = @order.order_items.new
    @rating.customer = current_customer
    if @rating.save
      flash[:success] = "Rating successfully created and waiting for review"
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :text, :book_id)
  end
end
