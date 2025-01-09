class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  # チャットルーム一覧を表示
  def index
    @chat_rooms = ChatRoom.all  # チャットルームの一覧を取得
    if @chat_rooms.any?
      @chat_room = @chat_rooms.first  # 最初のチャットルームを取得（例: 最初のチャットルームを表示）
      @messages = @chat_room.messages.order(created_at: :asc)  # 選択されたチャットルームのメッセージを取得
    else
      @chat_room = nil  # チャットルームがない場合の対応
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
      @chat_room.created_by_user_id = current_user.id  # 作成者を設定
  
      if @chat_room.save
        # チャットルームユーザーを作成（作成者を追加）
        ChatRoomUser.create(chat_room: @chat_room, user: current_user)
  
        # Turbo Stream を使わず、通常の HTML リダイレクト
        respond_to do |format|
          format.html do
            redirect_to chat_rooms_path, notice: 'チャットルームが作成されました。'
          end
          format.turbo_stream do
            # Turbo Stream を使ってサイドバーを更新する処理
            render turbo_stream: turbo_stream.append('chat_rooms_sidebar', partial: 'chat_rooms/room', locals: { chat_room: @chat_room })
          end
        end
      else
        render :new
      end
    end
  end
  
  
  
  

  # チャットルームを表示する
  def show
    @chat_room = ChatRoom.find(params[:id])  # チャットルームIDで検索
    @messages = @chat_room.messages.order(created_at: :asc)  # メッセージを作成日時の昇順で並べる
    # チャット画面の内容をレンダリングするために、このアクションが呼ばれる
  end

  private

  # チャットルーム作成のためのパラメータを許可
  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
