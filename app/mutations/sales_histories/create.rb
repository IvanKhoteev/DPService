module SalesHistories
  class Create < Mutations::Command
    required do
      model :trade_object
      float :sales_count
      float :sale_price, min: 0
    end

    def validate
      if sales_count <= 0
        add_error(:sales_count_less_or_equal_0, :current_price_less_then_minimum_price, "The sales count can't be less or equal 0")
      end
    end

    def execute
      trade_object.sales_count = sales_count
      trade_object.total_count_of_sales += sales_count
      trade_object.average_actual_current_price = (trade_object.average_actual_current_price * (trade_object.total_count_of_sales - sales_count) + sale_price * sales_count) / trade_object.total_count_of_sales
      trade_object.amount_of_sales = trade_object.amount_of_sales.blank? ? sale_price * sales_count : trade_object.amount_of_sales + sale_price * sales_count
      trade_object.save
      trade_object.sales_histories.create(inputs)
    end
  end
end
