class Projecttask < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :projecttask_title, presence: { message: "タスク名を入力してください" }
  validates :projecttask_content, presence: { message: "タスク内容を入力してください" }
end
