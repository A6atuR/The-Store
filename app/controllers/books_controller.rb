class BooksController < ApplicationController
  before_filter :authenticate_customer!
  authorize_resource

  def index
    @books = Book.all
    @order = current_customer.current_order
    @order_item = @order.order_items.new
  end

  def show
    @book = Book.find(params[:id])
    @order = current_customer.current_order
    @order_item = @order.order_items.new
    @rating = Rating.new
    @ratings = @book.ratings.where status: "approved"
  end
end