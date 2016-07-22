class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable , :omniauthable
         
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :qas, dependent: :destroy
  has_many :qacomments, dependent: :destroy

 #第一段階　「中間テーブルと関係を定義する」
  has_many :relationships,foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships,foreign_key:"followed_id",class_name: "Relationship", dependent: :destroy
  
  #第三段階　「相対的な参照を定義する」
  has_many :followed_users,through: :relationships,source: :followed
  has_many :followers,through: :reverse_relationships,source: :follower
  
  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :projecttasks, dependent: :destroy
  has_many :submit_requests, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :destroy

  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil) 
    user = User.where(provider: auth.provider, uid: auth.uid).first
   
    unless user 
     user = User.create(name: auth.extra.raw_info.name, 
                        provider: auth.provider, 
                        uid: auth.uid, 
                        #email: auth.info.email, 
                        email: User.get_email(auth),
                        password: Devise.friendly_token[0,20]
                        ) 
     user.skip_confirmation!
     user.save!
    end 
    user
  end
  
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil) 
   user = User.where(provider: auth.provider, uid: auth.uid).first
   #binding.pry
   
   unless user 
     user = User.create(name: auth.info.nickname, 
                        provider: auth.provider, 
                        uid: auth.uid, 
                        email: User.create_unique_email, 
                        password: Devise.friendly_token[0,20]
                        )
     user.skip_confirmation!
     user.save
   end 
  user
  end
  
  
  def self.create_unique_string 
    SecureRandom.uuid 
  end
  
  def self.create_unique_email 
     User.create_unique_string + "@example.com" 
  end
  
  #指定のユーザーをフォローする
  def follow!(other_user)
   relationships.create!(followed_id: other_user.id)
  end
  
  #指定のユーザーのフォローを解除する
   def unfollow!(other_user)
    relationships.find_by(followed_id: other_user).destroy
  end
  
   #フォローしているかどうか確認する
   def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
   end
  
   #自分がフォローしあっているユーザを確認する
   def friend
    User.from_users_followed_by(self)
   end
   
  #フォローしあっているユーザ一覧を取得する
   def self.from_users_followed_by(user)
     followed_user_ids="SELECT X.id FROM (SELECT users.* FROM
     users INNER JOIN relationships ON users.id =
     relationships.followed_id WHERE relationships.follower_id = :user_id )
     X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships
     ON users.id = relationships.follower_id WHERE 
     relationships.followed_id = :user_id ) Y ON X.id = Y.id"
     where("id IN (#{followed_user_ids})", user_id: user.id)
   end
    
  #フォローしている人のタスクフィードを取得する
  def taskfeed
   tasks = Task.where(user_id: self)
   Task.from_users_followed_by(self).order("updated_at DESC")
  end

  
  mount_uploader :image, ImageUploader
  
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: { message: "メールアドレスを入力してください" }, length: { maximum: 255 ,message: "255文字以内でご入力ください"},
               format: { with: VALID_EMAIL_REGEX,message: "メールアドレス形式でご入力ください　(例)user@example.co.jp" }
  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
      email
    end

end
