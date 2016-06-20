class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  has_many :projecttasks, dependent: :destroy
  has_many :memberships, dependent: :destroy
  


  
end
