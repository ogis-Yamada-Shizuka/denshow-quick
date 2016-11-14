json.array!(@depts) do |dept|
  json.extract! dept, :id, :name, :project
  json.url dept_url(dept, format: :json)
end
