class SalesHistoriesController < ApplicationController

  def index
    @sales_histories = SalesHistory.all
  end

  def new
    @sales_history = SalesHistory.new
  end

  def edit
    @sales_history = SalesHistory.find(params[:id])
  end

  def create
    outcome = SalesHistories::Create.run(trade_object: trade_object,
                                         sales_count: params[:sales_history][:sales_count],
                                         actual_current_price: params[:sales_history][:actual_current_price])
    if outcome.success?
      @sales_history = outcome.result
      flash[:success] = "The Sales Data was successfuly added"
      redirect_to trade_objects_path
    else
      flash[:warning] = "When added Sales Data took place the following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def update
    outcome = SalesHistories::Update.run(trade_object: trade_object,
                                         sales_count: params[:sales_history][:sales_count],
                                         actual_current_price: params[:sales_history][:actual_current_price],
                                         id: params[:id])
    if outcome.success?
      @sales_history = outcome.result
      flash[:success] = "The Sales Data was successfuly updated"
      redirect_to trade_object_sales_histories_path(trade_object)
    else
      flash[:warning] = "When updated Sales Data took place the following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def destroy
    sales_history = SalesHistory.find(params[:id])
    if sales_history.date_of_implementation_strategy.blank?
      sales_count = sales_history.sales_count
      sale_price = sales_history.sale_price
      new_total_count_of_sales  = trade_object.total_count_of_sales - sales_count
      new_average_actual_current_price = ( trade_object.average_actual_current_price * trade_object.total_count_of_sales - sales_count * sale_price ) / new_total_count_of_sales
      trade_object.update(total_count_of_sales: new_total_count_of_sales,
                          average_actual_current_price: new_average_actual_current_price)
    end
    sales_history.destroy
    redirect_to trade_object_sales_histories_path(trade_object)
  end

  private

  def trade_object
    TradeObject.find(params[:trade_object_id])
  end

end
