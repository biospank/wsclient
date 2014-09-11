json.array!(@reports) do |report|
  json.extract! report, :id, :index
  json.url report_url(report, format: :json)
end
