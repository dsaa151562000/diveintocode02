class Project < ActiveRecord::Base

  belongs_to :user
  belongs_to :customer
  has_many :projecttasks, dependent: :destroy
  has_many :memberships, dependent: :destroy
  validates :title, presence: { message: "プロジェクト名を入力してください" }
  validates  :content, presence: { message: "内容を入力してください" }
  validates :deadline, timeliness: { on_or_after: :now }

end
