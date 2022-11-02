json.extract! report, :id, :title, :description, :patente, :date, :created_at, :updated_at
json.url report_url(report, format: :json)
