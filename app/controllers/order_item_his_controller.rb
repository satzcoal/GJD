class OrderItemHisController < ApplicationController
  before_action :set_order_item_hi, only: [:show, :edit, :update, :destroy]

  # GET /order_item_his
  # GET /order_item_his.json
  def index
    @order_item_his = OrderItemHi.all
  end

  # GET /order_item_his/1
  # GET /order_item_his/1.json
  def show
  end

  # GET /order_item_his/new
  def new
    @order_item_hi = OrderItemHi.new
  end

  # GET /order_item_his/1/edit
  def edit
  end

  # POST /order_item_his
  # POST /order_item_his.json
  def create
    @order_item_hi = OrderItemHi.new(order_item_hi_params)

    respond_to do |format|
      if @order_item_hi.save
        format.html { redirect_to @order_item_hi, notice: 'Order item hi was successfully created.' }
        format.json { render :show, status: :created, location: @order_item_hi }
      else
        format.html { render :new }
        format.json { render json: @order_item_hi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_item_his/1
  # PATCH/PUT /order_item_his/1.json
  def update
    respond_to do |format|
      if @order_item_hi.update(order_item_hi_params)
        format.html { redirect_to @order_item_hi, notice: 'Order item hi was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item_hi }
      else
        format.html { render :edit }
        format.json { render json: @order_item_hi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_item_his/1
  # DELETE /order_item_his/1.json
  def destroy
    @order_item_hi.destroy
    respond_to do |format|
      format.html { redirect_to order_item_his_url, notice: 'Order item hi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item_hi
      @order_item_hi = OrderItemHi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_hi_params
      params.require(:order_item_hi).permit(:BaseOrder_id, :Item_id, :BasePrice, :SalPrice, :Discount, :CreateTime, :BatchId, :GoDown_id, :Sum, :ExceUser, :ExceDate)
    end
end
