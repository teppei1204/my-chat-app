class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name, null: false, unique: true # チャットルーム名（ユニーク）
      t.references :created_by_user, null: false, foreign_key: { to_table: :users } # ルームを作成したユーザー（外部キー）

      t.timestamps
    end
  end
end
