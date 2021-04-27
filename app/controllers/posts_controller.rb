class PostsController < ApplicationController
  before_action :ensure_correct_post, only: [:update, :edit, :destroy]
  before_action :authenticate_user!, except: [:index]

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to post_path(@post)
    else
      @posts = Post.all.includes(:user, :course).order(created_at: :desc).page(params[:page]).per(15)
      flash.now[:danger] = "投稿できませんでした"
      render "index"
    end
  end

  def index
    @posts = Post.all.includes(:user, :course).order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes([:user])
    @comment = current_user.comments.new
  end

  def edit
    @post = Post.find(params[:id])
    @course = @post.course
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集しました"
      redirect_to post_path(@post)
    else
      @post = Post.find(params[:id])
      @course = @post.course
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:warning] = "削除しました"
    redirect_to '/'
  end

  private

  def ensure_correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to post_path(@post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :rate, :user_id, :course_id, post_images_images: [])
  end
end
