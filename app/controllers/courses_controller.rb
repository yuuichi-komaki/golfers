class CoursesController < ApplicationController
  
  def new
    @course = Course.new
  end 
  
  def create
    @course = Course.new(course_params)
    @course.save
    redirect_to "/"
  end

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    # 暫定で以下
    @posts = @course.posts.page(params[:page]).reverse_order 
    # @posts = Post.where(course_id: :@course).order(created_at: :desc).page(params[:page])
    @post = Post.new
  end

  def destroy
  end
  
  
  private

  def course_params
    params.require(:course).permit(:name, :postcode, :prefecture_code, :address_city, :address_street)
  end
end
