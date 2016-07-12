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
      
      #Pusherに「notifications〜」というチャンネルで接続する、という意味です。
      #メッセージを送付した「受け手」のIDを指定して通知させます。
      #トリガーを「message」という名前にします。そのトリガーに変数として「messaging」を受け渡し、その中身としてメッセージの内容（本文）を入れます。
      
      #最初に会話が発生した際に、受取人（recipient)になった方に、常に、プッシュ通知が届きますね（どちらがメッセージを送ったとしても）。
      #Pusher['notifications'+@message.conversation.recipient_id.to_s].trigger('message', {messaging: "メッセージが届いています。：#{@message.body}"})
      
      #メッセージの送り手のidが会話の送り手のユーザーなら
      if @message.user_id == @conversation.sender_id
        　#メッセージを送付した「受け手」のID　.recipient_idを指定して通知させます。
          Pusher['notifications' + @message.conversation.recipient_id.to_s].trigger('message', {messaging: "メッセージが届いてます: #{@message.body}"})
      else
        #そうじゃないなら
          Pusher['notifications' + @message.conversation.sender_id.to_s].trigger('message', {messaging: "メッセージが届いてます: #{@message.body}"})
      end
      
      
      #会話にひもづくメッセージ一覧の画面に遷移する
      redirect_to conversation_messages_path(@conversation)
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
