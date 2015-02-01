class SaleOrdersController < ApplicationController
  before_action :set_sale_order, only: [:show, :edit, :update, :destroy]

  # GET /sale_orders
  # GET /sale_orders.json
  def index
    @sale_orders = SaleOrder.all
  end

  # GET /sale_orders/1
  # GET /sale_orders/1.json
  def show
  end

  # GET /sale_orders/new
  def new
    @sale_order = SaleOrder.new
  end

  # GET /sale_orders/1/edit
  def edit
  end

  # POST /sale_orders
  # POST /sale_orders.json
  def create
    @sale_order = SaleOrder.new(sale_order_params)

    respond_to do |format|
      if @sale_order.save
        format.html { redirect_to @sale_order, notice: 'Sale order was successfully created.' }
        format.json { render :show, status: :created, location: @sale_order }
      else
        format.html { render :new }
        format.json { render json: @sale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sale_orders/1
  # PATCH/PUT /sale_orders/1.json
  def update
    respond_to do |format|
      if @sale_order.update(sale_order_params)
        format.html { redirect_to @sale_order, notice: 'Sale order was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale_order }
      else
        format.html { render :edit }
        format.json { render json: @sale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_orders/1
  # DELETE /sale_orders/1.json
  def destroy
    @sale_order.destroy
    respond_to do |format|
      format.html { redirect_to sale_orders_url, notice: 'Sale order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_order
      @sale_order = SaleOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_order_params
      params.require(:sale_order).permit(:id)
    end
end
