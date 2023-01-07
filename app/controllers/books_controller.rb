class BooksController < ApplicationController
  
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}

  def new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to  user_path(current_user.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end
  
  def show
    @user = User.find(current_user.id)
    @book = Book.new
    @Book_detail = Book.find(params[:id])
  end
  
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end


private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end