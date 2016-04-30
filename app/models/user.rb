class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable # confirmableを追加
         
  has_many :blogs
  
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "メールアドレスを入力してください" }, length: { maximum: 255 ,message: "255文字以内でご入力ください"},
                    format: { with: VALID_EMAIL_REGEX,message: "メールアドレス形式でご入力ください　(例)user@example.co.jp" }
end
