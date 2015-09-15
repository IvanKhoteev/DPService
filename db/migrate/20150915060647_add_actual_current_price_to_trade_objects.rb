class AddActualCurrentPriceToTradeObjects < ActiveRecord::Migration
  def change
    add_column :trade_objects, :actual_current_price, :decimal, precision: 15, scale: 2
    add_column :trade_objects, :average_actual_current_price, :decimal,precision: 15, scale: 2
  end
end
