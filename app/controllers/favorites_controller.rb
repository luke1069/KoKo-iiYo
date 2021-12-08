class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(post_id: @post.id)
    favorite.user_id = current_user.id
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: @post.id, user_id: current_user.id)
    if favorite.user_id == current_user.id
      favorite.destroy
    end
    # redirect_to request.referer
  end

end
