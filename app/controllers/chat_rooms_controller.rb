class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:show, :destroy]

  # チャットルーム一覧を表示
  def index
    @chat_rooms = ChatRoom.all
    if @chat_rooms.any?
      @chat_room = @chat_rooms.first
      @messages = @chat_room.messages.order(created_at: :asc)
    else
      @chat_room = nil
      @messages = []
    end
  end

  # 新規チャットルーム作成フォームを表示
  def new
    @chat_room = ChatRoom.new
  end

  # チャットルームを作成する
  def create
    existing_room = current_user.chat_rooms.find_by(name: chat_room_params[:name])
    
    if existing_room
      flash.now[:alert] = 'このルーム名はすでに使用されています。別の名前を選んでください。'
      @chat_room = ChatRoom.new(chat_room_params)
      render :new
    else
      @chat_room = current_user.chat_rooms.build(chat_room_params)
      @chat_room.created_by_user_id = current_user.id
      
      if @chat_room.save
        # チャットルーム作成後、ユーザーをそのルームに追加
        ChatRoomUser.create(chat_room: @chat_room, user: current_user)
      
        # 作成後にトップページにリダイレクト
        redirect_to chat_rooms_path, notice: 'チャットルームが作成されました。'
      else
        render :new
      end
    end
  end
  

  # チャットルームを表示する
  def show
    @chat_room = ChatRoom.find_by(id: params[:id])
    if @chat_room.nil?
      flash[:alert] = '指定されたチャットルームは存在しません。'
      redirect_to chat_rooms_path
    else
      @messages = @chat_room.messages.order(created_at: :asc)
    end
  end
  
  
  

  # チャットルームを削除する
  def destroy
    @chat_room.destroy
  
    # Turbo Stream で削除を反映
    respond_to do |format|
      format.html { redirect_to chat_rooms_path, notice: 'チャットルームが削除されました。' }
      format.turbo_stream do
        # Turbo Stream メッセージを返して、削除されたチャットルームをサイドバーから削除
        render turbo_stream: turbo_stream.remove("chat-room-#{@chat_room.id}")
      end
    end
  end
  
  
  
  
  

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
