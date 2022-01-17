class MessagesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @message.save
      @messages = Message.where(room_id: @message.room_id)
      #   redirect_to room_path(@message.room_id)
      # else
      #   redirect_to room_path(@message.room_id)
      # end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id
      @messages = Message.where(room_id: @message.room_id)
      @message.destroy
      # redirect_to room_path(@message.room_id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id)
  end

end
