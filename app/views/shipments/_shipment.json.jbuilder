json.extract! shipment, :id, :name, :email, :phone_number, :address, :city, :zipcode, :country, :track_number, :status, :method, :payment_id, :payment_type, :collection_id, :collection_status, :preference_id, :merchant_order_id, :cart_id, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
