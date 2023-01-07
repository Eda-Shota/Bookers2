class UsersController < ApplicationController

  before_action :ensure_correct_user, {only:[:edit, :update]}

 def index
   @user = User.find(current_user.id)
   @book = Book.new
   @users = User.all
 end

 def show
  @user = User.find(current_user.id)
  @book = Book.new
  @show_user = User.find(params[:id])
 end

 def edit
  @user = User.find(current_user.id)
 end

 def update
  @user = User.find(current_user.id)
  if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
     redirect_to user_path(@user.id)
  else
   render :edit
  end
 end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  
 private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end