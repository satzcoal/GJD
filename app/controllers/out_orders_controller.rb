# encoding: utf-8
class OutOrdersController < ApplicationController

  # GET /out_orders
  # GET /out_orders.json
  def index
    @out_order = OutOrder.where(:State => "新建")
  end

  # GET /out_orders/1
  # GET /out_orders/1.json
  def show
    puts params
    @orderid = params[:id]
    @out_order = OutOrder.where(:id => @orderid)
  end

  # GET /out_orders/new
  def new
    @out_order = OutOrder.new
  end

  # GET /out_orders/1/edit
  def edit
  end

  # POST /out_orders
  # POST /out_orders.json
  def create
    @out_order = OutOrder.new(out_order_params)

    respond_to do |format|
      if @out_order.save
        format.html { redirect_to @out_order, notice: 'Out order was successfully created.' }
        format.json { render :show, status: :created, location: @out_order }
      else
        format.html { render :new }
        format.json { render json: @out_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def exec
    @outorderid = params[:id]
    @out_order = OutOrder.find(@outorderid)
    @order = BaseOrder.find(@out_order.Order_id)
    @gd = GoDown.find(@out_order.GoDown_id)
    @o_order_items = @out_order.out_order_items
  end

  # POST /in_orders
  # POST /in_orders.json
  def outgodown
    out_order = OutOrder.find(params.require(:out_order).permit(:id)[:id])
    baseorder = BaseOrder.find(out_order.Order_id)
    for x in 1..out_order.out_order_items.count
      tmp = params.require("itemline#{x}").permit(:out_item_id, :Sum)
      #得到出库物品的物品编号、生产批次、生产日期、仓库id
      outitem = OutOrderItem.find(tmp[:out_item_id])
      puts "Item_id:#{outitem.Item_id}\tBatchId:#{outitem.BatchId}\tCreateTime:#{outitem.CreateTime}"
      #查询库存
      #      @gditem = GoDownItem.where(:Item_id => outitem.Item_id, :GoDown_id => outitem.GoDown_id, :BatchId => outitem.BatchId, :CreateTime => outitem.CreateTime).first()
      gditem = GoDownItem.where(:Item_id => outitem.Item_id, :GoDown_id => outitem.GoDown_id, :BatchId => outitem.BatchId, :CreateTime => outitem.CreateTime).first()
      puts gditem.Sum
      sum=tmp[:Sum].to_i
      if gditem.Sum < sum
        #库存不足
        redirect_to "/out_orders/exec/#{out_order.id}"
      else
        #更新仓库库存数量
        gditem.update(:Sum => gditem.Sum-sum)
        #插入出库历史表
        outitemhis = OutOrderItemHis.new()
        outitemhis.OOrder_id = outitem.OOrder_id
        outitemhis.OutOrder_id = outitem.OutOrder_id
        outitemhis.Item_id = outitem.Item_id
        outitemhis.GoDown_id = outitem.GoDown_id
        outitemhis.BatchId = outitem.BatchId
        outitemhis.CreateTime = outitem.CreateTime
        outitemhis.Sum =tmp[:Sum]
        outitemhis.ExecTime =Time.new.strftime("%Y-%m-%d %H:%M:%S")
        outitemhis.Execer = "陈晓雨"
        outitemhis.save
        #更新出库单
        out_order.update(:State => "已出库", :Execer => "陈晓雨", :ExecTime => Time.new.strftime("%Y-%m-%d %H:%M:%S"))
        #更新原料出库单
        baseorder.update(:State => "已出库")
      end
    end

    #redirect_to @out_order
  end

  # PATCH/PUT /out_orders/1
  # PATCH/PUT /out_orders/1.json
  def update
    respond_to do |format|
      if @out_order.update(out_order_params)
        format.html { redirect_to @out_order, notice: 'Out order was successfully updated.' }
        format.json { render :show, status: :ok, location: @out_order }
      else
        format.html { render :edit }
        format.json { render json: @out_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /out_orders/1
  # DELETE /out_orders/1.json
  def destroy
    @out_order.destroy
    respond_to do |format|
      format.html { redirect_to out_orders_url, notice: 'Out order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_out_order
    @out_order = OutOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def out_order_params
    params.require(:out_order).permit(:Order_id, :GoDown_id, :OutOrderId, :Name, :Type, :CreateTime, :CreateUser, :ExecTime, :Execer, :State)
  end
end
