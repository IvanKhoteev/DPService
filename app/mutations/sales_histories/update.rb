module SalesHistories
  class Update < Mutations::Command
    required do
      model   :trade_object
      float   :sales_count
      float   :sale_price, min: 0
      integer :id
    end

    def validate
      if sales_count <= 0
        add_error(:sales_count_less_or_equal_0, :current_price_less_then_minimum_price, "The sales count can't be less or equal 0")
      end
    end

    def execute
      old_sales_history = SalesHistory.find(id)
      if old_sales_history.date_of_implementation_strategy.blank?
        old_sales_count = old_sales_history.sales_count
        old_sale_price  = old_sales_history.sale_price
        old_amount_of_sales = old_sales_count * old_sale_price
        trade_object.amount_of_sales += sales_count * sale_price - old_amount_of_sales
        old_average_actual_current_price = trade_object.average_actual_current_price
        delta_total_volume_of_sales = old_average_actual_current_price * trade_object.total_count_of_sales - old_sales_count * old_sale_price
        trade_object.total_count_of_sales += sales_count - old_sales_count
        trade_object.average_actual_current_price = ( delta_total_volume_of_sales + sale_price * sales_count ) / trade_object.total_count_of_sales
        trade_object.save
      else
        # Here was added actions when strategy was implementating
      end
      trade_object.sales_histories.update(id, inputs)
    end
  end
end
