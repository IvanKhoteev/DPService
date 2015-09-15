class AddDateOfImplementationStrategyToSalesHistories < ActiveRecord::Migration
  def change
    add_column :sales_histories, :date_of_implementation_strategy, :datetime
  end
end
