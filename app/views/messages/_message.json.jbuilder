json.extract! message, :id, :title, :description, :image_data, :message_type, :src, :dest, :created_at, :updated_at
json.url message_url(message, format: :json)
