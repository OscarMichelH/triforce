class RemoveSellerColumnFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :seller
  end
end
