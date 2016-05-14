class Contact < ActiveRecord::Base
    validates :name, presence: { message: "名前を入力してください" }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "メールアドレスを入力してください" }, length: { maximum: 255 ,message: "255文字以内でご入力ください"},
                    format: { with: VALID_EMAIL_REGEX,message: "メールアドレス形式でご入力ください　(例)user@example.co.jp" }
    
    #validates :email, presence: { message: "メールアドレスを入力してください" }
    validates :message, presence: { message: "お問い合わせ内容を入力してください" }
end
