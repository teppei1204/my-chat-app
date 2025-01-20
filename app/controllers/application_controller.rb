class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログアウト後に新規登録ページにリダイレクト
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path 
  end

  protected

  def configure_permitted_parameters
    # サインアップ時にusernameを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
  end
end