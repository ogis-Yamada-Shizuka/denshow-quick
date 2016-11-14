json.array!(@flow_orders) do |flow_order|
  json.extract! flow_order, :id, :order, :project_flg, :dept_id
  json.url flow_order_url(flow_order, format: :json)
end
