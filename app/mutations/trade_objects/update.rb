module TradeObjects
  class Update < Mutations::Command
    required do
      string  :name
      float   :current_price, min: 0
      float   :minimum_price, min: 0
      integer :id
    end
    
    optional do
      string  :kind_of_object
    end

    def validate
      add_error(:price_less_min,
                :current_price_less_then_minimum_price,
                "The current price can not be less than the minimum established price") if current_price < minimum_price
    end

    def execute
      trade_object = TradeObject.find(id)
      average_actual_current_price = trade_object.sales_histories.blank? ? 0 : trade_object.average_actual_current_price
      trade_object.update(inputs.merge(average_actual_current_price: average_actual_current_price))
      trade_object
    end
  end
end