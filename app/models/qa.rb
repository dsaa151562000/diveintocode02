class Qa < ActiveRecord::Base
  belongs_to :user
  has_many :qacomments, dependent: :destroy
end