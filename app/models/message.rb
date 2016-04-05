class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat
  has_many :deleted_messages

  validates :content, presence: true, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :chat_id, presence: true

  def self.search_by_content(content)
    where("content LIKE ?", "%#{content}%")
  end

  # Returns chat messages that haven't been removed by current user
  def self.chat_messages_for_user(chat, user)
    message_ids = "SELECT message_id FROM deleted_messages
                    WHERE user_id = :user_id"
    where("id NOT IN (#{message_ids}) AND chat_id = :chat_id",
          user_id: user.id, chat_id: chat.id)
  end
end
