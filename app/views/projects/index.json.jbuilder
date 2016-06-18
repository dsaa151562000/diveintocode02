json.array!(@projects) do |project|
  json.extract! project, :id, :user_id, :title, :content, :deadline, :customer_id, :done, :status
  json.url project_url(project, format: :json)
end
