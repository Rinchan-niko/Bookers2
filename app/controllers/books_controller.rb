class BooksController < ApplicationController
  def index
    @books = Book.find(params[:id])
  end

  def show
  end

  def edit
  end
end
