json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :code, :name
  json.url vendor_url(vendor, format: :json)
end
