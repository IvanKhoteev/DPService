class AddActualCurrentPriceToSalesHistories < ActiveRecord::Migration
  def change
    add_column :sales_histories, :actual_current_price, :decimal, precision: 15, scale: 2
  end
end
