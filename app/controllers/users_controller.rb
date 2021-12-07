class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会処理を完了しました。"
    redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :mybike, :prefecture, :skill )
  end

end
