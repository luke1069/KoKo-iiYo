class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def following
    @user = User.find(params[:user_id])
    @users = @user.followings
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
    # チャット機能(条件分岐)
    # @users.each_with_index do |following_u, i|
    #   @user_i = following_u
    #   @currentUserEntry = Entry.where(user_id: current_user.id)
    #   @userEntry = Entry.where(user_id: @user_i.id)
    #   unless @user_i.id == current_user.id
    #     @currentUserEntry.each do |cu|
    #       @userEntry.each do |u|
    #         if cu.room_id == u.room_id
    #           @haveRoom = true
    #           @roomId = cu.room_id
    #         end
    #       end
    #     end
    #   end
    #   unless @haveRoom == true
    #     @room = Room.new
    #     @entry = Entry.new
    #   end
    # end
  end

  def followed
    @user = User.find(params[:user_id])
    @users = @user.followers
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
    # チャット機能(条件分岐)
    # @users.each_with_index do |followed_u, i|
    #   @user_i = followed_u
    #   @currentUserEntry = Entry.where(user_id: current_user.id)
    #   @userEntry = Entry.where(user_id: @user_i.id)
    #   unless @user_i.id == current_user.id
    #     @currentUserEntry.each do |cu|
    #       @userEntry.each do |u|
    #         if cu.room_id == u.room_id
    #           @haveRoom = true
    #           @roomId = cu.room_id
    #         end
    #       end
    #     end
    #   end
    #   unless @haveRoom == true
    #     @room = Room.new
    #     @entry = Entry.new
    #   end
    # end
  end
end
