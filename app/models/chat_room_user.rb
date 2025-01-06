class ChatRoomUser < ApplicationRecord
  # Userとの関連付け
  belongs_to :user

  # ChatRoomとの関連付け
  belongs_to :chat_room
end
