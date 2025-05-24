class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @book = Book.new
    @users = User.all
    @user = User.find(current_user.id)
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    # ここから追加
    #user = User.find(params[:id])
    #unless user.id == current_user.id
      #redirect_to user_path(current_user.id)
    #end
    # ここまで追加（ユーザー制限）
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "Edit was successfully"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
