json.array!(@projecttasks) do |projecttask|
  json.extract! projecttask, :id, :user_id, :project_id, :projecttask_title, :projecttask_content, :projecttask_deadline, :projecttask_charge_id, :projecttask_done, :projecttask_status
  json.url projecttask_url(projecttask, format: :json)
end
