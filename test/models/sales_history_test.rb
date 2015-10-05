# == Schema Information
#
# Table name: sales_histories
#
#  id                              :integer          not null, primary key
#  sale_price                      :decimal(15, 2)
#  sales_count                     :float            default(0.0)
#  trade_object_id                 :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  date_of_implementation_strategy :datetime
#

require 'test_helper'

class SalesHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
