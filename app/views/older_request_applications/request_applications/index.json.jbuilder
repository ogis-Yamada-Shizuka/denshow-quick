json.array!(@request_applications) do |request_application|
  json.extract! request_application, :id, :management_no, :emargency, :filename, :request_date, :preferred_date, :close
  json.url request_application_url(request_application, format: :json)
end
