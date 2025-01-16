class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # Deviseのログアウト後のリダイレクト先を設定
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # サインアウト後はログインページにリダイレクト
  end
end
