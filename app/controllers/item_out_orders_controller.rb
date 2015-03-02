#encoding : utf-8
class ItemOutOrdersController < ApplicationController
  before_action :set_item_out_order, only: [:show, :edit, :update, :destroy, :split]

  # GET /item_out_orders
  # GET /item_out_orders.json
  def index
    @item_out_orders = ItemOutOrder.all
  end

  # GET /item_out_orders/1
  # GET /item_out_orders/1.json
  def show
    @orderitems = @item_out_order.order_items
  end

  # GET /item_out_orders/new
  def new
    @item_out_order = ItemOutOrder.new
    @GoDwons =GoDown.all
  end

  # GET /item_out_orders/1/edit
  def edit
  end

  def split

  end

  def CreateOutOrder
    item_out_order = ItemOutOrder.find(params[:id])\

    #得到用所选择的出库库存信息
    arygds = Array.new
    params.each do |p|
      tmpgd = /outOrder(\d{1,4})/.match(p[0])
      unless tmpgd.nil?
        arygds << tmpgd
      end
    end


    gods = Array.new
    items = Array.new
    for x in arygds
      tmp = params.require("#{x}").permit(:Item_Id, :BatchId, :CreateTime, :GoDown_id, :Sum)
      if tmp[:Sum] != ""
        gods<< tmp[:GoDown_id]
        items<<tmp
      end
    end

    i =0
    gods.each do |godid|
      i = i +1
      out_Order = OutOrder.new()
      out_Order.Order_id =item_out_order.id
      out_Order.GoDown_id = godid
      out_Order.OutOrderId ="#{item_out_order.OrderId}_#{i}"
      out_Order.State = "新建"
      out_Order.CreateTime= Time.new.strftime("%Y-%m-%d %H:%M:%S")
      out_Order.CreateUser ="陈晓雨"
      items.each do |item|
        if item[:GoDown_id] ==godid
          out_Order.out_order_items.build(:OOrder_id => item_out_order.id, :Item_id => item[:Item_Id], :GoDown_id => item[:GoDown_id], :BatchId => item[:BatchId], :CreateTime => item[:CreateTime], :Sum => item[:Sum])
        end
      end
      out_Order.save()
    end
    item_out_order.update(:State => "待出库")
  end

  # POST /item_out_orders
  # POST /item_out_orders.json
  def create

    @item_out_order = ItemOutOrder.new(item_out_order_params)
    @item_out_order.State= "新建"
    @item_out_order.CreateUser= "陈晓雨"
    @item_out_order.CreateTime = Time.now.localtime.strftime("%Y-%m-%d %H:%M:%S")
    #订单收货方信息
    worshop = WorkShop.find(@item_out_order.To)
    @item_out_order.To = worshop.name
    @item_out_order.ToAddress = worshop.address

    Item.where(:Type => "原料").each do |item|
      itemid = item.id
      itemCount = params[:"orderitemid_#{itemid}"]
      puts itemCount
      @item_out_order.order_items.build(:Item_id => itemid, :Sum => itemCount)
    end
    respond_to do |format|
      if @item_out_order.save
        format.html { redirect_to @item_out_order, notice: '原料出库订单已经创建成功！' }
        format.json { render :show, status: :created, location: @item_out_order }
      else
        format.html { render :new }
        format.json { render json: @item_out_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_out_orders/1
  # PATCH/PUT /item_out_orders/1.json
  def update
    respond_to do |format|
      if @item_out_order.update(item_out_order_params)
        format.html { redirect_to @item_out_order, notice: 'Item out order was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_out_order }
      else
        format.html { render :edit }
        format.json { render json: @item_out_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_out_orders/1
  # DELETE /item_out_orders/1.json
  def destroy
    @item_out_order.destroy
    respond_to do |format|
      format.html { redirect_to item_out_orders_url, notice: 'Item out order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item_out_order
    @item_out_order = ItemOutOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_out_order_params
    params.require(:item_out_order).permit(:id, :OrderId, :To)
  end
end
