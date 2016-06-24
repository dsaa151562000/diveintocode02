class Projecttask < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  # validates :project_id , presence: { message: "aaaaaaa" }
  validates :projecttask_title, presence: { message: "タスク名を入力してください" }
  validates :projecttask_content, presence: { message: "内容を入力してください" }
  validates :projecttask_deadline, timeliness: { on_or_after: :now }
  
end
