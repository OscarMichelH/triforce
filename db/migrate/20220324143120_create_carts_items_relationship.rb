class CreateCartsItemsRelationship < ActiveRecord::Migration[6.1]
  def change
    create_join_table :carts, :items do |t|
      t.index :cart_id
      t.index :item_id
      t.timestamps
    end
  end
end
