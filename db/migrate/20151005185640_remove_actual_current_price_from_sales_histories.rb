class RemoveActualCurrentPriceFromSalesHistories < ActiveRecord::Migration
  def change
    remove_column :sales_histories, :actual_current_price, :decimal
  end
end
