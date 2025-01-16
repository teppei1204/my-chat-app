Rails.application.routes.draw do
  # Devise のルートは最初に記述
  devise_for :users, controllers: {
    sessions: 'users/sessions', # ログイン関連のカスタムコントローラ
    registrations: 'users/registrations' # サインアップ関連のカスタムコントローラ（必要に応じて）
  }

  # ルートをチャットルーム一覧ページに変更
  root to: "chat_rooms#index" # チャットルームの一覧ページに変更

  # チャットルームに関するルーティング
  resources :chat_rooms, only: [:new, :create, :index, :show, :destroy] do
    # チャットルーム内のメッセージに関するルーティング
    resources :messages, only: [:create, :index]  # メッセージの作成と表示
  end
end
