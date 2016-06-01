class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable , :omniauthable
         
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
     user.save!

   end 
  user
  end
  
  
  def self.create_unique_string 
    SecureRandom.uuid 
  end
  
  def self.create_unique_email 
     User.create_unique_string + "@example.com" 
  end

         
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :qas, dependent: :destroy
  has_many :qacomments, dependent: :destroy
  
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
