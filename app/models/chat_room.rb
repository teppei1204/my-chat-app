# app/models/chat_room.rb
class ChatRoom < ApplicationRecord
  belongs_to :created_by_user, class_name: 'User', foreign_key: 'created_by_user_id'
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users
  has_many :messages, dependent: :destroy

  # バリデーション: チャットルーム名がユニークであること
  validates :name, presence: true, uniqueness: true
end
