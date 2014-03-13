class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @categories = Category.all
    @books = Book.page params[:page]
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @books = @category.books.page params[:page]
  end
end