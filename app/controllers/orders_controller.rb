# encoding: utf-8
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :split]
  # GET /orders
  # GET /orders.json


  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @sub_orders = @order.sub_orders
    # @sub_orders = SubOrder.where(OrderId:@order.OrderId)
    @GoDwons = GoDown.all
    if @order.Type=="1"
      @urlName ="生成入库单"
    else
      @urlName= "生成出库单"
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @type= params[:type]
    @order.Type=@type
    @GoDwons = GoDown.all

  end


  # GET /orders/1/edit
  def edit
    @GoDwons = GoDown.all
  end

  def split
    @i =1;
    @gdids = @order.sub_orders.select(:GoDown_id).map(&:GoDown_id).uniq
    puts @gdids.count
    @order.sub_orders.select(:GoDown_id).map(&:GoDown_id).uniq.each do |gdid|
      puts "gdid:#{gdid}"
      if @order.Type =="1"
        @InOrder = InOrder.new()
        @InOrder.InOrderId = "#{@order.OrderId}_#{@i.to_s}"
        @InOrder.GoDown_id = gdid
        @InOrder.Type= @order.Type
        @InOrder.Order_id = @order.id
        @InOrder.State = "新建"
        @InOrder.save();
      else
        @OutOrder = OutOrder.new()
        @OutOrder.OutOrderId = "#{@order.OrderId}_#{@i.to_s}"
        @OutOrder.GoDown_id = gdid
        @OutOrder.Type= @order.Type
        @OutOrder.Order_id = @order.id
        @OutOrder.State = "新建"
        @OutOrder.save();
      end
      @i = @i+1
    end

    if @order.Type=="1"
      @order.update(:State => "待入库")
      redirect_to "/in_orders/#{@order.id}"

    else
      @order.update(:State => "待出库")
      redirect_to "/out_orders/#{@order.id}"
    end

  end

  # POST /orders
  # POST /orders.json
  def create
    puts params;
    @order = Order.new(order_params)
    @order.State = "新建"
    @order.CreateTime= Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @order.CreateUser ="陈晓雨"
    # @items.append(@tmp)

    respond_to do |format|
      if @order.save
        for x in 1..10
          @tmp = params.require("itemline#{x}").permit(:Item_id, :Sum, :GoDown_id)
          if (@tmp[:Item_id] !="")
            puts @tmp
            @sub_order =SubOrder.new(:Item_id => @tmp[:Item_id], :Sum => @tmp[:Sum], :GoDown_id => @tmp[:GoDown_id])
            @sub_order.Order_id= @order.id
            @sub_order.save
          end
        end

        format.html { redirect_to @order, notice: '订单创建成功' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update

    respond_to do |format|
      if @order.update(order_params)
        for x in 1..@order.sub_orders.count
          @tmp = params.require("itemline#{x}").permit(:id, :Item_id, :Sum, :GoDown_id)
          if (@tmp[:id] !="")
            puts @tmp
            @sub_order =SubOrder.find(@tmp[:id])
            @sub_order.update(@tmp)
          end
        end


        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to "/orders/?type=#{@order.Type}", notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:OrderId, :Name, :Type, :CreateTime, :CreateUser, :ExecTime, :Execer, :State)
  end
end
