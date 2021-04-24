class CommentsController < ApplicationController

  def create
   @comment = current_user.comments.new(comment_params)
   unless @comment.save
    render "error"
   end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end



  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
