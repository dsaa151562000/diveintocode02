class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :comment
end
