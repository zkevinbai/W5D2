class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = params[:post_id]
    # Fail
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id] unless @comment.post_id
    # Fail

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
