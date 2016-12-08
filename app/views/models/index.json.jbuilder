json.array!(@models) do |model|
  json.extract! model, :id, :code
  json.url model_url(model, format: :json)
end
