class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name, null: false
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    # name カラムにユニーク制約を追加
    add_index :chat_rooms, :name, unique: true
  end
end