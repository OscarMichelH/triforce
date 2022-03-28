class AddAppFeeToSales < ActiveRecord::Migration[6.1]
  def change
    add_column :sales, :app_fee, :float
  end
end
