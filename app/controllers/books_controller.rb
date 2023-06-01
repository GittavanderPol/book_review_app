class BooksController < ApplicationController
  include Pagy::Backend
  include SessionsHelper

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @books = pagy(Book.includes(:author).all)
    store_redirect_url(:add_book)
  end

  def new
    @book = Book.new(author_id: params[:author_id])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_back_or(:add_book, books_path)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def book_params
    params.require(:book).permit(:title, :author_id)
  end
end
