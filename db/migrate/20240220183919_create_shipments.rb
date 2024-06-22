class CreateShipments < ActiveRecord::Migration[7.1]
  def change
    create_table :shipments do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :city
      t.integer :zipcode
      t.string :country, default: 'MX'
      t.string :track_number, default: 'LOCAL'
      t.string :status, default: 'declined'
      t.string :method
      t.string :payment_id
      t.string :payment_type
      t.string :collection_id
      t.string :collection_status
      t.string :preference_id
      t.string :merchant_order_id
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
