class User < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :chat_users, dependent: :destroy
  has_many :chats, through: :chat_users

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name,
            presence: true,
            length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  ONLINE_PERIOD = 5.minutes

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def online?
    updated_at > ONLINE_PERIOD.ago
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
