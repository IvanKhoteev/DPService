# == Schema Information
#
# Table name: trade_objects
#
#  id                   :integer          not null, primary key
#  name                 :string
#  current_price        :decimal(15, 2)
#  minimum_price        :decimal(15, 2)
#  sales_count          :float            default(0.0)
#  total_count_of_sales :float            default(0.0)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class TradeObject < ActiveRecord::Base
end