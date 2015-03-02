#encoding : utf-8
class MakeOrdersController < ApplicationController
  before_action :set_make_order, only: [:show, :edit, :update, :destroy,:split]

  # GET /make_orders
  # GET /make_orders.json
  def index
    @make_orders = MakeOrder.all
  end

  # GET /make_orders/1
  # GET /make_orders/1.json
  def show
    @orderitems = @make_order.order_items
  end

  # GET /make_orders/new
  def new
    @make_order = MakeOrder.new
    @GoDwons = GoDown.all
    @workshop = Info::Provider.all
  end

  def split
    i =1;
    puts @make_order.State
    gdids = @make_order.order_items.select(:GoDown_id).map(&:GoDown_id).uniq
    puts gdids.count
    #根据仓库生成入库单
    gdids.each do |gdid|
      puts "gdid:#{gdid}"

      inorder = InOrder.new()
      inorder.InOrderId = "#{@make_order.OrderId}_#{i.to_s}"
      inorder.GoDown_id = gdid
      inorder.Order_id = @make_order.id
      inorder.State = "新建"


      inorder.save();

      i = i+1
    end
    @make_order.update(:State => "待入库")

    redirect_to "/in_orders/#{@make_order.id}"
  end

  # GET /make_orders/1/edit
  def edit
  end

  # POST /make_orders
  # POST /make_orders.json
  def create
    puts params
    @make_order = MakeOrder.new
    #订单基本信息
    @make_order.OrderId=make_order_params[:OrderId]
    @make_order.State= "新建"
    @make_order.MoneyState = ""
    @make_order.CreateUser= "陈晓雨"
    @make_order.CreateTime = Time.now.localtime.strftime("%Y-%m-%d %H:%M:%S")

    #生产车间信息  车间名称、车间地址、车间负责人、车间电话
    ws = WorkShop.find(make_order_params[:From])
    @make_order.From =ws.name
    @make_order.FromAddress =ws.address


    for x in 1..10
      @tmp = params.require("itemline#{x}").permit(:Item_id, :Sum, :GoDown_id, :BatchId, :CreateTime)
      if (@tmp[:Item_id] !="" && @tmp[:Sum] != "")
        puts @tmp
        #创建订单项：物品id,价格，数量，仓库
        puts @make_order.order_items
        @make_order.order_items.build(:Item_id => @tmp[:Item_id], :Sum => @tmp[:Sum], :GoDown_id => @tmp[:GoDown_id], :BatchId => @tmp[:BatchId],:CreateTime=>@tmp[:CreateTime])
      end
    end

    respond_to do |format|
      if @make_order.save
        format.html { redirect_to @make_order, notice: '产品入库单创建完成' }
        format.json { render :show, status: :created, location: @make_order }
      else
        format.html { render :new }
        format.json { render json: @make_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /make_orders/1
  # PATCH/PUT /make_orders/1.json
  def update
    respond_to do |format|
      if @make_order.update(make_order_params)
        format.html { redirect_to @make_order, notice: 'Make order was successfully updated.' }
        format.json { render :show, status: :ok, location: @make_order }
      else
        format.html { render :edit }
        format.json { render json: @make_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /make_orders/1
  # DELETE /make_orders/1.json
  def destroy
    @make_order.destroy
    respond_to do |format|
      format.html { redirect_to make_orders_url, notice: 'Make order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_make_order
    @make_order = MakeOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def make_order_params
    params.require(:make_order).permit(:OrderId,:From)
  end
end
