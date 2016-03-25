class Chat < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :chat_users, dependent: :destroy
  has_many :users, through: :chat_users

  validates :name,
            presence: true,
            length: { maximum: 50 }
end
