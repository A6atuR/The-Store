class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    @books = Book.all
    @order_item = @order.order_items.new
  end

  def show
    @order_item = @order.order_items.new
    @rating = Rating.new
    @ratings = @book.ratings.approved
  end
end