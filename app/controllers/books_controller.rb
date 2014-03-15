class BooksController < ApplicationController
  before_filter :authenticate_customer!
  load_and_authorize_resource

  def index
    @books = Book.all
    @order = current_customer.current_order
    @order_item = @order.order_items.new
  end

  def show
    @order = current_customer.current_order
    @order_item = @order.order_items.new
    @rating = Rating.new
    @ratings = @book.ratings.approved
  end
end