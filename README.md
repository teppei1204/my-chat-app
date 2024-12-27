## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 | integer | null: false, primary_key: true |ユーザーID (主キー)
| username           | string  | null: false, unique: true      |ユーザー名（ユニーク）
| email              | string  | null: false, unique: true      |メールアドレス（ユニーク）
| password_digest    | string  | null: false |ハッシュ化されたパスワード
| created_at         |  date   | null: false |登録日時
| updated_at         |  date   | null: false |更新日時

  # ユーザーは複数のメッセージを持つ（1対多）
  has_many :messages, dependent: :destroy

  # ユーザーは複数のチャットルームに参加する（多対多）
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users

  # ユーザーはプロフィール画像を1つ持つ（画像アップロード）
  has_one_attached :profile_image


## ChatRooms テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| id                 | integer | null: false, primary_key: true |チャットルームID (主キー)
| name               | string  | null: false, unique: true      |チャットルーム名（ユニーク）
| created_by_user_id | integer | null: false, foreign_key: true |ルームを作成したユーザーのID
| created_at         |  date   | null: false |作成日時
| updated_at         |  date   | null: false |更新日時

  # チャットルームは複数のユーザーに関連する（多対多）
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users

  # チャットルームは複数のメッセージを持つ（1対多）
  has_many :messages, dependent: :destroy


## Messages テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| id           | integer | null: false, primary_key: true |メッセージID (主キー)
| user_id      | integer | null: false, foreign_key: true |メッセージを送信したユーザーのID
| chat_room_id | integer | null: false, foreign_key: true |メッセージが投稿されたチャットルームのID
| content      |  text   | null: false |メッセージ内容（テキスト）
| image_url    |  string | null: false |画像のURL（オプション）
| created_at   |  date   | null: false |投稿日時

  # メッセージは1つのユーザーに所属する（多対1）
  belongs_to :user

  # メッセージは1つのチャットルームに所属する（多対1）
  belongs_to :chat_room

  # メッセージは画像を持つことができる
  has_one_attached :image


  ## ChatRoomUsers テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| id           | integer | null: false, primary_key: true |チャットルームメンバーID (主キー)
| user_id      | integer | null: false, foreign_key: true |参加ユーザーのID (外部キー)
| chat_room_id | integer | null: false, foreign_key: true |チャットルームID (外部キー)
| created_at   |  date   | null: false |参加日時

  # ChatRoomUserは1つのユーザーに属する（多対1）
  belongs_to :user

  # ChatRoomUserは1つのチャットルームに属する（多対1）
  belongs_to :chat_room


  ## Mentions テーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| id                | integer | null: false, primary_key: true |メンションID (主キー)
| message_id        | integer | null: false, foreign_key: true |メッセージID (外部キー)
| mentioned_user_id | integer | null: false, foreign_key: true |メンションされたユーザーID

  # メンションは1つのユーザーに関連（多対1）
  belongs_to :user

  # メンションは1つのメッセージに関連（多対1）
  belongs_to :message


## UserEdits テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| id         | integer | null: false, primary_key: true |編集履歴ID (主キー)
| user_id    | integer | null: false, foreign_key: true |ユーザーID (外部キー)
| field_name | string  | null: false |編集された項目の名前
| old_value  | 	text   | null: false |変更前の値
| new_value  |  text   | null: false |変更後の値
| created_at |  date   | null: false |編集日時

  # UserEditは1つのユーザーに関連する（多対1）
  belongs_to :user

  # UserEditはプロフィール画像が変更されることも想定し、画像の添付が可能
  has_one_attached :profile_image