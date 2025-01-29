## データベース設計

### users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| id                 | integer | null: false, primary_key: true |ユーザーID (主キー)
| username           | string  | null: false, unique: true      |ユーザー名（ユニーク）
| email              | string  | null: false, unique: true      |メールアドレス（ユニーク）
| password_digest    | string  | null: false |ハッシュ化されたパスワード
| created_at         |  date   | null: false |登録日時
| updated_at         |  date   | null: false |更新日時

  - ユーザーは複数のメッセージを持つ（1対多）
  - ユーザーは複数のチャットルームに参加する（多対多）
  - ユーザーはプロフィール画像を1つ持つ（画像アップロード）

### ChatRooms テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| id                 | integer | null: false, primary_key: true |チャットルームID (主キー)
| name               | string  | null: false, unique: true      |チャットルーム名（ユニーク）
| created_by_user_id | integer | null: false, foreign_key: true |ルームを作成したユーザーのID
| created_at         |  date   | null: false |作成日時
| updated_at         |  date   | null: false |更新日時

  - チャットルームは複数のユーザーに関連する（多対多）
  - チャットルームは複数のメッセージを持つ（1対多）

### Messages テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| id           | integer | null: false, primary_key: true |メッセージID (主キー)
| user_id      | integer | null: false, foreign_key: true |メッセージを送信したユーザーのID
| chat_room_id | integer | null: false, foreign_key: true |メッセージが投稿されたチャットルームのID
| content      |  text   | null: false |メッセージ内容（テキスト）
| image_url    |  string | null: false |画像のURL（オプション）
| created_at   |  date   | null: false |投稿日時

  - メッセージは1つのユーザーに所属する（多対1）
  - メッセージは1つのチャットルームに所属する（多対1）
  - メッセージは画像を持つことができる

### ChatRoomUsers テーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| id           | integer | null: false, primary_key: true |チャットルームメンバーID (主キー)
| user_id      | integer | null: false, foreign_key: true |参加ユーザーのID (外部キー)
| chat_room_id | integer | null: false, foreign_key: true |チャットルームID (外部キー)
| created_at   |  date   | null: false |参加日時

  - ChatRoomUserは1つのユーザーに属する（多対1）
  - ChatRoomUserは1つのチャットルームに属する（多対1）

### Mentions テーブル

| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| id                | integer | null: false, primary_key: true |メンションID (主キー)
| message_id        | integer | null: false, foreign_key: true |メッセージID (外部キー)
| mentioned_user_id | integer | null: false, foreign_key: true |メンションされたユーザーID

  - メンションは1つのユーザーに関連（多対1）
  - メンションは1つのメッセージに関連（多対1）

### UserEdits テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| id         | integer | null: false, primary_key: true |編集履歴ID (主キー)
| user_id    | integer | null: false, foreign_key: true |ユーザーID (外部キー)
| field_name | string  | null: false |編集された項目の名前
| old_value  | 	text   | null: false |変更前の値
| new_value  |  text   | null: false |変更後の値
| created_at |  date   | null: false |編集日時

  - UserEditは1つのユーザーに関連する（多対1）
  - UserEditはプロフィール画像が変更されることも想定し、画像の添付が可能
## アプリケーション名

  - 考察チャット

# ONE PIECE考察チャットアプリ

このアプリケーションは、**ONE PIECE** の原作が終了した後でも楽しめる深い考察を、**ファン同士で気軽にシェア・議論できる**チャットアプリです。アニメや漫画に描かれなかった部分や、今後明かされる可能性のある謎を考察し、ファン同士で意見を交換し合います。

## 概要

  - **対象ユーザー**: ONE PIECEのファンで、原作終了後でも考察を楽しみたい方
  - **特徴**: 未解決の謎や原作では描かれなかった部分をファン同士で議論し、意見を交換できる
  - **リアルタイムチャット**: Action Cableによるリアルタイム通信
  - **ユーザー参加型**: ユーザーは独自のチャットルームを作成して、好きなテーマで議論ができる

## 利用方法

### 1. サインイン / サインアップ
  - Basic認証ID       kabuki
  - Basic認証password 0009

### 2. チャットルームを作成 / 参加
  - ユーザーは、**自分が好きなテーマ（例：最終章で解明されなかった謎、描かれなかった登場人物の背景、未だに明かされていない伏線など）**をテーマにしたチャットルームを作成できます。
  - 「新規チャットルーム作成」ボタンを押して、ルーム名やテーマを設定し、「作成」ボタンで新しいチャットルームを作成します。

  - 既存のチャットルームに参加したい場合は、一覧から気になるルームを選んで参加することができます。

### 3. メッセージの送信
  - チャットルームに参加した後は、リアルタイムでメッセージを交換できます。
  - メッセージを入力して「送信」ボタンを押すと、他の参加者にも即時に反映されます。

### 4. ログアウト
  - 右上のユーザーアイコンから「ログアウト」ボタンを選択することで、セッションを終了し、ログイン画面にリダイレクトされます。

## アプリケーションの特徴

  - **原作終了後の考察を楽しむ**: ONE PIECEの最終章を終えた後でも、未解決の謎や未描写のキャラクターに関する考察を深堀りできます。これまでのストーリーに隠された秘密を、ファン同士で自由に共有・議論できます。
  - **深い議論が可能**: アプリでは、アニメや漫画に描かれなかった部分や、作者しか知らない伏線や裏設定に関する考察がメインです。ファン同士で、理論的に深く掘り下げた議論が可能です。
  - **リアルタイムメッセージング**: Action Cableによるリアルタイム通信で、他のユーザーと即座に意見を交換したり、考察をアップデートしたりできます。

  - **画像添付機能**: 画像を添付して、考察を視覚的に補強したり、過去のシーンやキャラクターの資料を共有したりできます。

  - **ユーザー参加型**: ユーザーは、好きなテーマを設定したチャットルームを作成したり、参加したりすることができます。例えば「ゾロの家系」や「エースとルフィの絆」など、自分が興味あるテーマで議論を始められます。

## アプリケーションを作成した背景

  - キャラクターをピンポイントで話し合える場がない
  - 先の物語を考察する時もっと詳しい人に蓋をされる
  - その投稿（SNS）を荒らすようなヤツがいる


## 実装した機能についての画像やGIFおよびその説明

  - [![Image from Gyazo](https://i.gyazo.com/81bb39881e4a1acc89acc5dbcdcc264f.png)](https://gyazo.com/81bb39881e4a1acc89acc5dbcdcc264f)

## 実装予定の機能

**ユーザープロフィールの詳細編集機能**  
  - RailsのActive Record, ActiveStorage, バリデーション

**メンション機能**  
  - Action Cable, 正規表現, 通知システム（ActionMailerなど）

**いいね機能**  
  - RailsのActive Record, AJAX/Turbo Streams

**チャットルームのジャンル別に選択できる機能**  
  - RailsのActive Record（モデル関連付け）, セレクトボックス, スコープ

**メッセージの削除、編集機能**  
  - RailsのActive Record, AJAX/Turbo Streams, 権限チェック

**通知機能**  
  - Action Cable, ActionMailer, 通知モデル

**アクセス解析機能**  
  - Google Analytics, Mixpanel, JavaScript

## データベース設計

  - [![Image from Gyazo](https://i.gyazo.com/3741c1e0c4cc109f0fe214a2c4e3925b.png)](https://gyazo.com/3741c1e0c4cc109f0fe214a2c4e3925b)

## 画面遷移図

  - [![Image from Gyazo](https://i.gyazo.com/23c165a324a65e2905a98e13bc259c5f.png)](https://gyazo.com/23c165a324a65e2905a98e13bc259c5f)

## 開発環境

  - **Ruby on Rails**: バックエンドフレームワーク
  - **MySQL**: 開発環境・テスト環境のデータベース
  - **PostgreSQL**: 本番環境のデータベース
  - **Action Cable**: リアルタイム通信
  - **Turbo**: ページ遷移を高速化するためのツール
  - **JavaScript**: フロントエンドのインタラクション

## ローカルでの動作方法

  - ユーザーログインまたは新規登録を行います。「チャットを作成する」から任意の名前で作成し、文章を投稿します。既存のルームがある場合ルーム名をクリックし参加します。  

## 工夫したポイント

  - **非同期通信によるリアルタイムメッセージング**  
ActionCableを使用したリアルタイムメッセージング機能を実装し、ユーザーがページをリロードすることなくチャットメッセージをリアルタイムで受け取れる仕組みを作成しました。
  - **直感的でシンプルなUI**  
チャットルームとメッセージの送信画面を統合し、ユーザーが直感的に操作できるインターフェースを実現しました。特に、シンプルで使いやすいデザインに重点を置きました。