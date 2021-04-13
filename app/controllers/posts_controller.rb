class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.save!
    redirect_to "/"
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :course_id, post_images_images: [])
  end
end
