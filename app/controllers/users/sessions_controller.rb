class Users::SessionsController < Devise::SessionsController
  # ログイン後のリダイレクト先を変更したい場合
  def after_sign_in_path_for(resource)
    chat_rooms_path # ログイン後、チャットルーム一覧ページにリダイレクト
  end

  # createメソッドのカスタマイズ
  def create
    # params[:user][:username]が送信されているか確認
    logger.debug "Login attempt with username: #{params[:user][:username]}"

    super # Deviseのデフォルト処理を実行
  end

  def destroy
    super  # Deviseのdestroyアクションを呼び出してログアウトを処理
    # Turbo を無効化してフルリダイレクトでログインページに遷移
    # redirect_to new_user_session_path and return
  end
end
