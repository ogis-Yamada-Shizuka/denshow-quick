json.array!(@progresses) do |progress|
  json.extract! progress, :id, :flow_id, :in_date, :out_date
  json.url progress_url(progress, format: :json)
end
