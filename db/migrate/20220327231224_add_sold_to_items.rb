class AddSoldToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :sold, :boolean, default: false
  end
end
