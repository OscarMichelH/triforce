class AddFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :role, :string, default: 'BUYER'
    add_column :users, :balance, :float, default: 50.0
  end
end
