class HomesController < ApplicationController
  def top
    @posts = Post.all.includes(:user, :course, :post_images).order(created_at: :desc).page(params[:page]).per(6)
  end
end
