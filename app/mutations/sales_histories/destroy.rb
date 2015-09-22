module SalesHistories
  class Destroy < Mutations::Command
    required do
      model   :trade_object
      integer :id
    end

    def execute
      sales_history = SalesHistory.find(id)
      if sales_history.date_of_implementation_strategy.blank?
        sales_count = sales_history.sales_count
        sale_price = sales_history.sale_price
        new_total_count_of_sales  = trade_object.total_count_of_sales - sales_count
        new_average_actual_current_price = new_total_count_of_sales == 0 ? 0 : ( trade_object.average_actual_current_price * trade_object.total_count_of_sales - sales_count * sale_price ) / new_total_count_of_sales
        trade_object.update(total_count_of_sales: new_total_count_of_sales,
                            average_actual_current_price: new_average_actual_current_price,
                            amount_of_sales: trade_object.amount_of_sales - sales_count * sale_price)
      end
      sales_history.destroy
      end
  end
end
