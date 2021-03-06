class MessagesController < ApplicationController
  before_action :signed_in_user
  after_action :user_activity

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
    message = Message.find(params[:edited_message])
    if current_user? message.user
      message.update_attribute(:content, params[:message][:content])
    end
    redirect_to message.chat
  end

  def destroy
    message = Message.find(params[:message_id])
    DeletedMessage.create(message_id: message.id, user_id: current_user.id)
    redirect_to message.chat
  end
end
