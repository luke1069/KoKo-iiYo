class MessagesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        redirect_to room_path(@message.room_id)
      else
        redirect_to room_path(@message.room_id)
      end
    end
  end

  def destroy
    @message = Message.find(:id)
    @message.destroy
    redirect_to room_path(@message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :message).merge(user_id: current_user.id)
  end

end
