#encoding: utf-8
class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy, :split]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    @orderitems = @purchase_order.order_items
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new

    @GoDwons = GoDown.all
    @providers = Info::Provider.all
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    puts params
    @purchase_order = PurchaseOrder.find_or_create_by(:OrderId => purchase_order_params[:OrderId])
    #订单基本信息
    @purchase_order.State= "新建"
    @purchase_order.MoneyState = "待付款"
    @purchase_order.CreateUser= "陈晓雨"
    @purchase_order.CreateTime = Time.now.localtime.strftime("%Y-%m-%d %H:%M:%S")
    #订单供货商信息
    @purchase_order.From = "李靖超" #供货商名称
    @purchase_order.FromAddress = "北京市海淀区知春路1号学院国际" #供货商地址
    @purchase_order.From_Back = "工商银行 北京分行 车道沟支行" #供货商银行-开户行
    @purchase_order.From_BackAccountNum = "6222020200087654321" #供货商帐号
    @purchase_order.From_BackAccountName = "李靖超" #供货商银行注册名称

    #订单收货方信息
    #针对系统使用应做一个基本信息设置
    @purchase_order.To = "陈晓雨" #进货者名称
    @purchase_order.ToAddress = "北京市海淀区大柳树北路17号911" #收货地址
    @purchase_order.To_Back = "中国银行 北京分行 皂君庙支行" #
    @purchase_order.To_BackAccountNum= "622202020012345678" #银行帐号
    @purchase_order.To_BackAccountName = "陈晓雨" #银行帐号注册名称

    @FactTotal = 0
    @tmptotal =0
    for x in 1..10
      @tmp = params.require("itemline#{x}").permit(:Item_id, :Sum, :GoDown_id, :FactSalePrice)
      if (@tmp[:Item_id] !="" && @tmp[:Sum] != "")
        puts @tmp
        #创建订单项：物品id,价格，数量，仓库
        puts @purchase_order.order_items
        @purchase_order.order_items.build(:Item_id => @tmp[:Item_id], :Sum => @tmp[:Sum], :GoDown_id => @tmp[:GoDown_id], :SalPrice => @tmp[:FactSalePrice])

        @tmptotal = @tmp[:FactSalePrice].to_d * @tmp[:Sum].to_i
        @FactTotal = @FactTotal+@tmptotal
      end
    end
    #订单总额
    @purchase_order.FactTotal = @FactTotal
    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: '采购订单创建完成' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end


  def split
    i =1;
    puts @purchase_order.State
    gdids = @purchase_order.order_items.select(:GoDown_id).map(&:GoDown_id).uniq
    puts gdids.count
    #根据仓库生成入库单
    gdids.each do |gdid|
      puts "gdid:#{gdid}"

      inorder = InOrder.new()
      inorder.InOrderId = "#{@purchase_order.OrderId}_#{i.to_s}"
      inorder.GoDown_id = gdid
      inorder.Order_id = @purchase_order.id
      inorder.State = "新建"


      inorder.save();

      i = i+1
    end
    @purchase_order.update(:State => "待入库", :MoneyState => "代付款")

    redirect_to "/in_orders/#{@purchase_order.id}"
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_order_params
    params.require(:purchase_order).permit(:OrderId, :Total, :FactTotal, :From, :FromAddress, :From_Back, :From_BackAccountNum, :From_BackAccountName, :To, :ToAddress, :To_Back, :To_BackAccountNum, :To_BackAccountName, :MoneyState, :State, :CreateTime, :CreateUser)
  end
end
