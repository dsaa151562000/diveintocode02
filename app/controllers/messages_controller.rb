class MessagesController < ApplicationController
  #どの会話なのかの処理を各アクションではなく共通の処理としてbefore_actionに定義
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    
    #会話にひもづくメッセージを取得する
    @messages = @conversation.messages
    
    #もしメッセージの数が10よりも大きければ...
    if @messages.length > 10
      #10より大きいというフラグを有効にして
      @over_ten = true
      #メッセージを最新の10に絞ることをする
      @messages = @messages[-10..-1]
    end
    
    #そうでなければ
    if params[:m]
      #10より大きいというフラグを無効
      @over_ten = false
      #会話にひもづくメッセージをすべて取得する
      @messages = @conversation.messages
    end
    
    #もしメッセージが最新（最後）のメッセージで
    #lastメソッドは、配列の最後の要素を返します。配列が空のときはnilを返します。
    if @messages.last
      #且つユーザIDが自分（ログインユーザ）であれば
      if @messages.last.user_id != current_user.id
         #その最新（最後）のメッセージを既読にする
         @messages.last.read = true;
      end
    end
    
    #新規投稿のメッセージ用の変数を作成する
    @message = @conversation.messages.new
    
  end


  def new
     @message = @conversation.messages.new
  end

  def create
    #HTTPリクエスト上のパラメータを利用して会話にひもづくメッセージを生成
    @message = @conversation.messages.new(message_params)
    #保存ができれば
    if @message.save
      #会話にひもづくメッセージ一覧の画面に遷移する
      redirect_to conversation_messages_path(@conversation)
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
