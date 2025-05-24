class FavoritesController < ApplicationController
  before_action :set_book

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    respond_to do |format|
      format.js  # create.js.erb で処理を返す
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy if favorite
    respond_to do |format|
      format.js  # destroy.js.erb で処理を返す
    end
  end
  

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
