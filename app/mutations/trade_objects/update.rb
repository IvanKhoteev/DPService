module TradeObjects
  class Update < Mutations::Command
    required do
      string  :name
      float   :current_price, min: 0
      float   :minimum_price, min: 0
      integer :id
    end

    def validate
      add_error(:price_less_min,
                :current_price_less_then_minimum_price,
                "The current price can not be less than the minimum established price") if current_price < minimum_price
    end

    def execute
      TradeObject.update(id, inputs)
    end
  end
end