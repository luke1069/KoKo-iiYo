class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      @comment = Comment.new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
    end
    @post = Post.find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
