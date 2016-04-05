class ChatsController < ApplicationController
  before_action :signed_in_user
  before_action only: [:edit, :update, :show] do
    chat_member(Chat.find(params[:id]))
  end
  after_action :user_activity

  def index
    @chats = Chat.where(private: false).joins(:messages).group("chats.id").order("count(*) DESC")
                 .paginate(page: params[:page], per_page: 15)
  end

  def show
    @chat = Chat.find(params[:id])
    @members = @chat.users.paginate(page: params[:page], per_page: 10)
    @messages = Message.chat_messages_for_user(@chat, current_user)
    @message = current_user.messages.build(chat_id: @chat.id)
    @chat_user = ChatUser.find_by(chat_id: @chat.id, user_id: current_user.id)
  end

  def members
    @chat = Chat.find(params[:id])
    if !@chat.private
      @title = @chat.name
      @members = @chat.users.paginate(page: params[:page], per_page: 20)
      render 'show_members'
    else
      redirect_to chats_path
    end
  end

  def new
  end

  def create
    chat = Chat.create(name: "New Chat")
    ChatUser.create(chat_id: chat.id, user_id: current_user.id)

    if params[:user_id]
      ChatUser.create(chat_id: chat.id, user_id: params[:user_id])
    end
    redirect_to chat
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    @chat.update_attributes(chat_params)
    redirect_to @chat
  end

  private
  def chat_params
    params.require(:chat).permit(:name, :private)
  end
end
