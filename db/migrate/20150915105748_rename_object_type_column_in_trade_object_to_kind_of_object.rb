class RenameObjectTypeColumnInTradeObjectToKindOfObject < ActiveRecord::Migration
  def change
    rename_column :trade_objects, :object_type, :kind_of_object
  end
end
