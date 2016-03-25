class
MessagesController < ApplicationController
  before_action :signed_in_user

  def create
    message = Message.new(content: params[:message][:content],
                          user_id: params[:user_id],
                          chat_id: params[:chat_id])
    if message.save
      redirect_to message.chat
    else
      redirect_to Chat.find(params[:chat_id])
    end
  end

  def update
    @message = Message.find(params[:id])
    @message.update_attribute(:content, params[:content])
    redirect_to @message.chat
  end

  def destroy
    message = Message.find(params[:id])
    chat = message.chat
    message.destroy
    redirect_to chat
  end
end
