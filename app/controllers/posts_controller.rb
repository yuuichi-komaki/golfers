class PostsController < ApplicationController

  def create
    # byebug
    @post = Post.new(post_params)
    @post.save!
    redirect_to "/"
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = current_user.comments.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/'
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :rate, :user_id, :course_id, post_images_images: [])
  end
end
