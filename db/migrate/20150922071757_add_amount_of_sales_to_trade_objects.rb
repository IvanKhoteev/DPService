class AddAmountOfSalesToTradeObjects < ActiveRecord::Migration
  def change
    add_column :trade_objects, :amount_of_sales, :decimal, precision: 15, scale: 2, default: 0
  end
end
