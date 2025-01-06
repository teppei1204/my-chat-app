class Users::SessionsController < Devise::SessionsController
  # ログイン後のリダイレクト先を変更したい場合
  def after_sign_in_path_for(resource)
    chat_rooms_path # ログイン後、チャットルーム一覧ページにリダイレクト
  end
end
