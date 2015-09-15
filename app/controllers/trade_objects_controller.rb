class TradeObjectsController < ApplicationController

  def index
    @trade_objects = TradeObject.all.order(created_at: :desc)
  end

  def new
    @trade_object = TradeObject.new
  end

  def create
    outcome = TradeObjects::Create.run(trade_object_params)
    if outcome.success?
      @trade_object = outcome.result
      flash[:success] = "The Trade Object '#{@trade_object.name}' was successfuly created"
      redirect_to trade_objects_path
    else
      flash[:warning] = "When you create any following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def show
    @trade_object = TradeObject.find(params[:id])
  end

  def edit
    @trade_object = TradeObject.find(params[:id])    
  end

  def update
    outcome = TradeObjects::Update.run(trade_object_params.merge(id: params[:id]))
    if outcome.success?
      @trade_object = outcome.result
      flash[:success] = "The Trade Subject '#{@trade_object.name}' was successfuly updated"
      redirect_to trade_objects_path
    else
      flash[:warning] = "When you create any following errors: #{outcome.errors.message_list}"
      redirect_to request.referer
    end
  end

  def destroy
    trade_object = TradeObject.find(params[:id])
    trade_object.destroy
    redirect_to root_path
  end

  private

  def trade_object_params
    params.require(:trade_object).permit(:name, :object_type, :current_price, :minimum_price)
  end

end
