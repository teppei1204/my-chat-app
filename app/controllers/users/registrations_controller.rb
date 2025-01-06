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
  end

  # ここでサインイン後のリダイレクト先をカスタマイズできます
  def after_sign_up_path_for(resource)
    chat_rooms_path # 例: サインアップ後にチャットルームの一覧ページにリダイレクト
  end
end
