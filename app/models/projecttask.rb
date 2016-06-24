class Projecttask < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :projecttask_title, presence: { message: "プロジェクト名を入力してください" }
end
