class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
  end
end