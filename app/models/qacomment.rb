class Qacomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :qa
end