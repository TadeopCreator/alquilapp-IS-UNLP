json.extract! usuario, :id, :name, :lastname, :dni, :contact, :lon, :lat, :deleted, :enable, :birthdate, :image_data, :date_licence, :id_wallet, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
