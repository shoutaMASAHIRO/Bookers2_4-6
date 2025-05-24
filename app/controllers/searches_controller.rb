class SearchesController < ApplicationController
    before_action :authenticate_user!
  
    def search
      @word = params[:word]
      @range = params[:range]
      @search_method = params[:search_method]
  
      if @range == "User"
        @users = User.search_for(@word, @search_method)
      elsif @range == "Book"
        @books = Book.search_for(@word, @search_method)
      end
    end
  end
  