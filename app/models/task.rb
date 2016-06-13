class Task < ActiveRecord::Base
  has_many :task_comments, dependent: :destroy
  has_many :goodjobs, dependent: :destroy
  belongs_to :user
  belongs_to :charge, class_name: 'User', foreign_key: 'charge_id'
  validates :title, presence: true
  
   #フォローしあっているユーザIDを取得する
   def self.from_users_followed_by(user)
     followed_user_ids="SELECT X.id FROM (SELECT users.* FROM
     users INNER JOIN relationships ON users.id =
     relationships.followed_id WHERE relationships.follower_id = :user_id )
     X INNER JOIN (SELECT users.* FROM users INNER JOIN relationships
     ON users.id = relationships.follower_id WHERE 
     relationships.followed_id = :user_id ) Y ON X.id = Y.id"
     where("id IN (#{followed_user_ids})", user_id: user.id)
   end
  
end
