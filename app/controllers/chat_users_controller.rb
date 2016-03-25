class ChatUsersController < ApplicationController
  before_action :signed_in_user
  before_action only: [:destroy] do
    chat_member(ChatUser.find(params[:id]).chat)
  end

  def create
    chat = Chat.find(params[:chat_id])
    ChatUser.create(chat_id: chat.id, user_id: current_user.id)
    redirect_to chat
  end

  def destroy
    ChatUser.find(params[:id]).destroy
    redirect_to current_user
  end
end
