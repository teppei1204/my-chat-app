Rails.application.routes.draw do
  # Devise のルートは最初に記述
  devise_for :users  # カスタムコントローラーは削除

  # ルートをチャットルーム一覧ページに変更
  root to: "chat_rooms#index" # チャットルームの一覧ページに変更

  # チャットルームに関するルーティング
  resources :chat_rooms, only: [:new, :create, :index, :show, :destroy] do
    # チャットルーム内のメッセージに関するルーティング
    resources :messages, only: [:create, :index]  # メッセージの作成と表示
  end
end
