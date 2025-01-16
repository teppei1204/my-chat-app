class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
    # アカウント削除後にリダイレクトしたい場合は、ここで指定
    redirect_to root_path and return
  end

  # ここでサインイン後のリダイレクト先をカスタマイズできます
  def after_sign_up_path_for(resource)
    chat_rooms_path # 例: サインアップ後にチャットルームの一覧ページにリダイレクト
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_registration_path # 新規登録ページにリダイレクト
  end
end
