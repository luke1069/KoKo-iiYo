class PostsController < ApplicationController

  before_action :authenticate_user!

# 新着投稿一覧
  def index
    @posts = Post.all.order(id: "DESC").page(params[:page]).per(4)
  end

# 人気投稿一覧
  def ranking_index
    @posts = Post.includes(:favorites).
    sort { |a,b|
      b.favorites.count <=>
      a.favorites.count
    }
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
  end

# お気に入り投稿一覧
  def favorites_index
    favorites = Favorite.where(user_id: current_user.id).order(id: "DESC").pluck(:post_id)
    @posts = Post.find(favorites)
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(4)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿を完了しました。"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    unless ImpressionsCount.find_by(user_id: current_user.id, post_id: @post.id)
      current_user.impressions_counts.create(post_id: @post.id)
    end
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      render :edit
    else
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿内容を変更しました。"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def search_index
    @q = Post.ransack(params[:q])
    @results = @q.result(distinct: true).order(created_at: "DESC").page(params[:page]).per(4)
    @check = params[:q]
  end

 private

  def post_params
    params.require(:post).permit(:title, :body, :image, :post_prefecture, :rate, :lat, :lng)
  end

end
