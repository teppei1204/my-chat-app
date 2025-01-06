class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room

  def create
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user  # メッセージ送信者を現在のユーザーに設定

    if @message.save
      # Turbo Stream でメッセージを追加
      respond_to do |format|
        format.html { redirect_to chat_room_path(@chat_room) }  # HTMLの場合は通常のリダイレクト
        format.turbo_stream { render turbo_stream: turbo_stream.append("messages", render_to_string(partial: "messages/message", locals: { message: @message })) }
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
    params.require(:message).permit(:content)  # メッセージの内容
  end
end
