class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # チャットルーム一覧を表示
  def index
    @chat_rooms = current_user.chat_rooms.includes(:chat_room_users)
  end
  
  # 新規チャットルーム作成フォームを表示
  def new
    @chat_room = ChatRoom.new
  end

  # チャットルームを作成する
  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    @chat_room.created_by_user_id = current_user.id  # 作成者を設定
  
    if @chat_room.save
      # チャットルームユーザーを作成（作成者を追加）
      ChatRoomUser.create(chat_room: @chat_room, user: current_user)
  
      respond_to do |format|
        format.html { redirect_to chat_rooms_path, notice: 'チャットルームが作成されました。' }
        format.turbo_stream { render turbo_stream: turbo_stream.append('chat_rooms', @chat_room) }
      end
    else
      render :new
    end
  end
  

  # チャットルームを表示する
  def show
    @chat_room = ChatRoom.find(params[:id])  # チャットルームIDで検索
  end

  private

  # チャットルーム作成のためのパラメータを許可
  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
