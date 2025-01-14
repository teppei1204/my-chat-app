class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user  # メッセージ送信者を現在のユーザーに設定

    if @message.save
      # Turbo Stream でメッセージを追加
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("messages", render_to_string(partial: "messages/message", locals: { message: @message })),
            turbo_stream.replace("message_form", partial: "messages/main_chat_form", locals: { chat_room: @chat_room }) # フォームをリセット
          ]
        end
      end
    else
      flash.now[:alert] = @message.errors.full_messages.to_sentence
      render "chat_rooms/show"  # エラーメッセージを表示して同じページに戻る
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])  # チャットルームを設定
  end

  def message_params
    # メッセージ内容と画像を許可する
    params.require(:message).permit(:content, :image)  # メッセージの内容と画像
  end
end
