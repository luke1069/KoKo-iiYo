class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: "DESC").page(params[:page]).per(4)
    # チャット機能
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @haveRoom = true
            @roomId = cu.room_id
          end
        end
      end
    end
    unless @haveRoom
      @room = Room.new
      @entry = Entry.new
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報を変更しました。"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      reset_session
      flash[:notice] = "退会処理を完了しました。"
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :mybike, :prefecture, :skill )
  end

end
