class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :ensure_current_user, only: [:edit,:update,:destroy]
  def new
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books =  Book.where(user_id: @user.id)
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def book_params
        params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_current_user
    @user = User.find(params[:id])
    redirect_to(books_path) unless @user == current_user
  end

end
