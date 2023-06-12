class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.float :percentage
      t.float :direct
      t.float :quantity
      t.integer :pieces
      t.string :type
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
