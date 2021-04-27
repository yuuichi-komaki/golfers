class CoursesController < ApplicationController
  before_action :user_admin, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :prefecture_courses]

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def index
    @courses = Course.all.includes(:posts).page(params[:page]).per(10)
  end

  def prefecture_courses
    @courses = Course.where(prefecture_code: params[:key]).page(params[:page]).per(10)
    @prefecture = Course.find_by(prefecture_code: params[:key])
  end

  def show
    @course = Course.find(params[:id])
    gon.course = @course
    @posts = @course.posts.includes(:user).page(params[:page]).reverse_order.per(7)
    @post = Post.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to root_path
  end

  def user_admin
    if current_user.admin == false
      redirect_to root_path
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :postcode, :prefecture_code, :address_city, :address_street, :address)
  end
end
