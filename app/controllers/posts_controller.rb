class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
   if  @post.save!
    redirect_to post_path(@post)
   else
    @course = Course.find(params[:id])
    gon.course = @course
    @posts = @course.posts.page(params[:page]).reverse_order
    render course_path(@course)
   end
  end

  def index
    @posts = Post.all.includes(:user, :course).order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = current_user.comments.new
  end

  def edit
    @post = Post.find(params[:id])
    @course = @post.course
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
     redirect_to post_path(@post)
    else
     render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/'
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :rate, :user_id, :course_id, post_images_images: [])
  end
end
