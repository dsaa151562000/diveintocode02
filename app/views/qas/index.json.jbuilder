json.array!(@qas) do |qa|
  json.extract! qa, :id, :title, :content, :category_id, :language_id
  json.url qa_url(qa, format: :json)
end
