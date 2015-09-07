class CreateTradeObjects < ActiveRecord::Migration
  def change
    create_table :trade_objects do |t|
      t.string :name
      t.decimal :current_price, precision: 15, scale: 2
      t.decimal :minimum_price, precision: 15, scale: 2
      t.float :sales_count, default: 0
      t.float :total_count_of_sales, default: 0

      t.timestamps null: false
    end
  end
end
