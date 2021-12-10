class HomesController < ApplicationController

def top
  @posts_new = Post.all.order(id: "DESC")
  @posts_favorite = Post.includes(:favorites).
    sort { |a,b|
      b.favorites.count <=>
      a.favorites.count
    }
end

end
