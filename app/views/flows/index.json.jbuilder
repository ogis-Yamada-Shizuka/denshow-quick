json.array!(@flows) do |flow|
  json.extract! flow, :id, :request_application_id, :order, :dept_id
  json.url flow_url(flow, format: :json)
end
