class CreateSalesHistories < ActiveRecord::Migration
  def change
    create_table :sales_histories do |t|
      t.decimal :sale_price, precision: 15, scale: 2
      t.float :sales_count, default: 0
      t.references :trade_object, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
