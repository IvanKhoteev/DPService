# == Schema Information
#
# Table name: trade_objects
#
#  id                           :integer          not null, primary key
#  name                         :string
#  kind_of_object               :string
#  current_price                :decimal(15, 2)
#  minimum_price                :decimal(15, 2)
#  sales_count                  :float            default(0.0)
#  total_count_of_sales         :float            default(0.0)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  actual_current_price         :decimal(15, 2)
#  average_actual_current_price :decimal(15, 2)
#

class TradeObject < ActiveRecord::Base
  has_many :sales_histories, dependent: :destroy
end
