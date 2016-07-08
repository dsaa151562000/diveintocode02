class Conversation < ActiveRecord::Base
    #Userモデルのモデル名にidをつけただけのカラムではないため、class_nameを明示的に指定する
    belongs_to :sender,    foreign_key: :sender_id,    class_name: 'User'
    belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
    
    #会話は複数のメッセージを保有し、会話が削除されたらメッセージも削除する
    has_many :messages, dependent: :destroy
    
    #送り手は受け手と重複しないことを制御しチェックする
    validates_uniqueness_of :sender_id, scope: :recipient_id
    
    #モデルにスコープを導入
    # scopeメソッドで定義:between   スコープに引数を指定 (sender_id,recipient_id) 
    #該当のユーザ間での会話が過去に存在しているかを確認する式です。
    # if Conversation.between(params[:sender_id], params[:recipient_id]).present?
    scope :between, -> (sender_id,recipient_id) do
        where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
    end
    
    def target_user(current_user)
        if sender_id == current_user.id
            User.find(recipient_id)
        elsif recipient_id == current_user.id
            User.find(sender_id)
        end
    end
    
end
