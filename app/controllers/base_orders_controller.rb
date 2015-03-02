class BaseOrdersController < ApplicationController
  before_action :set_base_order, only: [:show, :edit, :update, :destroy]

  # GET /base_orders
  # GET /base_orders.json
  def index
    @base_orders = BaseOrder.all
  end

  # GET /base_orders/1
  # GET /base_orders/1.json
  def show
  end

  # GET /base_orders/new
  def new
    @base_order = BaseOrder.new
  end

  # GET /base_orders/1/edit
  def edit
  end

  # POST /base_orders
  # POST /base_orders.json
  def create
    @base_order = BaseOrder.new(base_order_params)

    respond_to do |format|
      if @base_order.save
        format.html { redirect_to @base_order, notice: 'Base order was successfully created.' }
        format.json { render :show, status: :created, location: @base_order }
      else
        format.html { render :new }
        format.json { render json: @base_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_orders/1
  # PATCH/PUT /base_orders/1.json
  def update
    respond_to do |format|
      if @base_order.update(base_order_params)
        format.html { redirect_to @base_order, notice: 'Base order was successfully updated.' }
        format.json { render :show, status: :ok, location: @base_order }
      else
        format.html { render :edit }
        format.json { render json: @base_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_orders/1
  # DELETE /base_orders/1.json
  def destroy
    @base_order.destroy
    respond_to do |format|
      format.html { redirect_to base_orders_url, notice: 'Base order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_order
      @base_order = BaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def base_order_params
      params.require(:base_order).permit(:OrderId, :type, :Total, :FactTotal, :From, :FromAddress, :From_Back, :From_BackAccountNum, :From_BackAccountName, :To, :ToAddress, :To_Back, :To_BackAccountNum, :To_BackAccountName, :MoneyState, :State, :CreateTime, :CreateUser)
    end
end
