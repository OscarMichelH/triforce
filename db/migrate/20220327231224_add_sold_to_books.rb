class AddSoldToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :sold, :boolean, default: false
  end
end
