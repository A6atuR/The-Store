class RatingsController < ApplicationController
  authorize_resource

  def create
    @book = Book.find(params[:book_id])
    @rating = current_customer.ratings.create(rating_params)
    redirect_to book_path(@book)
  end

  private

  def rating_params
    params.require(:rating).permit(:rating, :text, :book_id)
  end
end
