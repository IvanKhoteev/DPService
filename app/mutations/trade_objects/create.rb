module TradeObjects
  class Create < Mutations::Command
    required do
      string :name
      float  :current_price, min: 0
      float  :minimum_price, min: 0
      string :kind_of_object
    end

    def validate
      if current_price < minimum_price
        add_error(:price_less_min, :current_price_less_then_minimum_price, "The current price can not be less than the minimum established price")
      end
    end

    def execute
      TradeObject.create!(inputs.merge(actual_current_price: current_price, average_actual_current_price: 0))
    end
  end
end
