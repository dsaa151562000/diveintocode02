class MessagesController < ApplicationController
  #どの会話なのかの処理を各アクションではなく共通の処理としてbefore_actionに定義
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
  end

  def new
  end

  def create
  end
end
