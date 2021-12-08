class CommentsController < ApplicationController
  
  def create
    post = Post.find(params[:post_id])
    comment = Commnet.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:comment)
    end
  
end
