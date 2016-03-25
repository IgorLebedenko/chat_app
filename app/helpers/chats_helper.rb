module ChatsHelper

  def member?(chat)
    ChatUser.find_by(chat_id: chat.id, user_id: current_user.id)
  end

  def chat_member(chat)
    unless member? chat
      redirect_to chats_path
    end
  end

end
