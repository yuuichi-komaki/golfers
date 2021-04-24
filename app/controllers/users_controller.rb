class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
  before_action :authenticate_user!, except: [:index]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order.per(5)
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_list = Post.find(favorites)
  end

  def index
    @users = User.all.includes(:posts)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/'
  end

 private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
