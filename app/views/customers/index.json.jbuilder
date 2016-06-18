json.array!(@customers) do |customer|
  json.extract! customer, :id, :project_id, :customer_name
  json.url customer_url(customer, format: :json)
end
