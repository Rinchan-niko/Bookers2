class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_book,only: [:edit]

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      @nbook = Book.new
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @nbook = Book.new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @nbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
