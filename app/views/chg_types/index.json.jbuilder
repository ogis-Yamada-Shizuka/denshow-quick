json.array!(@chg_types) do |chg_type|
  json.extract! chg_type, :id, :name
  json.url chg_type_url(chg_type, format: :json)
end
