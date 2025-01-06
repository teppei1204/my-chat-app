# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user      # メッセージを送信したユーザー
  belongs_to :chat_room # メッセージが属するチャットルーム
  
  # メッセージ内容のバリデーション
  validates :content, presence: true

  # 画像の添付がある場合、画像URLも保存される
  has_one_attached :image
end
