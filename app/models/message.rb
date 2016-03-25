class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :content, presence: true, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :chat_id, presence: true
end