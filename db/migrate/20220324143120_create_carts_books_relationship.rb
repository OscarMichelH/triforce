class CreateCartsBooksRelationship < ActiveRecord::Migration[6.1]
  def change
    create_join_table :carts, :books do |t|
      t.index :cart_id
      t.index :book_id
      t.timestamps
    end
  end
end
