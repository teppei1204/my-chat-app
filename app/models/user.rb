class User < ApplicationRecord
  # バリデーション
  validates :username, presence: true, uniqueness: true, length: { maximum: 255 }

  # アソシエーション
  has_many :messages, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users

  # プロフィール画像の添付
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
