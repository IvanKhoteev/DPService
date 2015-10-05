class SalesHistoriesController < ApplicationController

  def index
    @trade_object = TradeObject.find(params[:trade_object_id])
    @sales_histories = @trade_object.sales_histories
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
                                         sale_price: params[:sales_history][:sale_price])
    if outcome.success?
      @sales_history = outcome.result
      if @sales_history.sale_price < trade_object.minimum_price
        flash[:danger] = "The Sales Data was successfuly added, BUT This Sale Price Less The Minimum Price"
      else
        flash[:success] = "The Sales Data was successfuly added"
      end
      redirect_to trade_objects_path
    else
      flash[:warning] = "When added Sales Data took place the following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def update
    outcome = SalesHistories::Update.run(trade_object: trade_object,
                                         sales_count: params[:sales_history][:sales_count],
                                         sale_price: params[:sales_history][:sale_price],
                                         id: params[:id])
    if outcome.success?
      @sales_history = outcome.result
      if @sales_history.sale_price < trade_object.minimum_price
        flash[:danger] = "The Sales Data was successfuly updeted, BUT This Sale Price Less The Minimum Price"
      else
        flash[:success] = "The Sales Data was successfuly updeted"
      end
      redirect_to trade_object_sales_histories_path(trade_object)
    else
      flash[:warning] = "When updated Sales Data took place the following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def destroy

    outcome = SalesHistories::Destroy.run(trade_object:trade_object,
                                          id: params[:id])
    if outcome.success?
      flash[:success] = "The Sales Data was successfuly deleted"
      redirect_to trade_object_sales_histories_path(trade_object)
    else
      flash[:warning] = "When deleted Sales Data took place the following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  private

  def trade_object
    TradeObject.find(params[:trade_object_id])
  end

end
