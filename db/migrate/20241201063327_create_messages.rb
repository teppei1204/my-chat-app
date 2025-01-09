class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content, null: false # メッセージの内容
      t.references :user, null: false, foreign_key: true # ユーザーID（外部キー）
      t.references :chat_room, null: false, foreign_key: true # チャットルームID（外部キー）

      t.timestamps
    end
  end
end
