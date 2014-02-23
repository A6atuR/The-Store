class BooksController < ApplicationController
  before_filter :authenticate_customer!

  def main
    @books = Book.all
    @order = current_customer.orders.find_by status: "shopping_cart"
    @order_item = @order.order_items.new
  end

  def show
    @category = Category.find(params[:category_id])
    @book = @category.books.find(params[:id])
    @order = current_customer.orders.find_by status: "shopping_cart"
    @order_item = @order.order_items.new
    @rating = Rating.new
    @ratings = @book.ratings.where status: "approved"
  end

  def rating
    @category = Category.find(params[:category_id])
    @book = @category.books.find(params[:book_id])
    @rating = current_customer.ratings.create(rating_params)
    redirect_to category_book_path(@category, @book)
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :text, :book_id)
  end
end