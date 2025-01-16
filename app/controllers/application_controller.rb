class ApplicationController < ActionController::Base
  # deviseのサインアップ時、アカウント更新時、ログイン時にusernameを受け入れるための設定
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:index] # チャットルームの一覧ページ（root）は除外
  
  # ログアウト後に新規登録ページにリダイレクト
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path 
  end

  protected

  def configure_permitted_parameters
    # サインアップ時にusernameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])

    # アカウント更新時にusernameを許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])

    # ログイン時にusernameを許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
