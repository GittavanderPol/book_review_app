class AuthorsController < ApplicationController
  include Pagy::Backend
  include SessionsHelper

  before_action :set_author, only: [:edit, :update, :destroy]

  def index
    @pagy, @authors = pagy(Author.all)
  end

  def show
    @author = Author.includes(:books).find(params[:id])
    store_redirect_url(:add_book)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to authors_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      redirect_to author_path(@author)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_path, status: :see_other
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
