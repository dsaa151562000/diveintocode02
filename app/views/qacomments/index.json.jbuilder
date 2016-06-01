json.array!(@qacomments) do |qacomment|
  json.extract! qacomment, :id, :qa_id, :user_id, :content
  json.url qacomment_url(qacomment, format: :json)
end
