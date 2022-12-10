class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}


  def new
    @book = Book.new
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = current_user

  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="Book was succcessfully update."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroy."
      redirect_to books_path
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
    end

    def  ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
    end

end