# encoding: utf-8
class InOrdersController < ApplicationController

  # GET /in_orders
  # GET /in_orders.json
  def index
    @Orders = Order.where(:State => "待入库")
  end

  # GET /in_orders/1
  # GET /in_orders/1.json
  def show
    puts params
    @orderid = params[:id]
    @order = BaseOrder.find(@orderid)
    @in_orders = InOrder.where(:Order_id => @orderid)
    @gds = @in_orders.select(:GoDown_id).map(&:GoDown_id).uniq
  end

  def exec
    @inorderid = params[:id]
    @in_order = InOrder.find(@inorderid)
    @order = BaseOrder.find(@in_order.Order_id)
    @gd = GoDown.find(@in_order.GoDown_id)
    @sub_orders = OrderItem.where(:BaseOrder_id => @order.id, :GoDown_id => @gd.id)
  end

  # GET /in_orders/new
  def new
    @in_order = InOrder.new
  end

  # GET /in_orders/1/edit
  def edit
  end

  # POST /in_orders
  # POST /in_orders.json
  def ingodown
    puts params
    inorder = InOrder.find(params.require(:in_order).permit(:id)[:id])
    baseorder = BaseOrder.find(inorder.Order_id)
    puts baseorder.OrderId
    puts baseorder.From
    itemcount =params.require(:items).permit(:count)[:count]
    for x in 1..itemcount.to_i
      tmp = params.require("itemline#{x}").permit(:Item_id, :Sum, :BatchId, :CreateTime, :Shelflife)
      if (tmp[:Item_id] !="")
        puts tmp

        # @godownitem =GoDownItem.new(:Item_id=>@tmp[:Item_id],:Sum=>@tmp[:Sum],:GoDown_id=>@inorder.GoDown_id,:CreateTime=>@tmp[:CreateTime],:ShelfLife=>@tmp[:ShelLeft],:MadeIn=>@tmp[:MadIn])
        godownitem =GoDownItem.new()
        godownitem.GoDown_id = inorder.GoDown_id
        godownitem.Item_id = tmp[:Item_id]
        godownitem.Sum=tmp[:Sum]
        godownitem.CreateTime=tmp[:CreateTime]
        godownitem.ShelfLife=tmp[:Shelflife]
        godownitem.MadeIn=baseorder.From
        godownitem.BatchId=tmp[:BatchId]
        godownitem.Execer = "陈晓雨"
        godownitem.State = "入库"
        godownitem.InTime =Time.new.strftime("%Y-%m-%d %H:%M:%S")
        godownitem.save
      end
    end
    inorder.update(:State => "已执行", :Execer => "陈晓雨", :ExecTime => Time.new.strftime("%Y-%m-%d %H:%M:%S"))
    orderstate= InOrder.where(:State => "已执行", :Order_id => baseorder.id, :State => "新建").count()
    if orderstate ==0
      baseorder.update(:State=>"已入库")
    end
    redirect_to "/in_orders/"

  end

  # POST /in_orders
  # POST /in_orders.json
  def create
    @in_order = InOrder.new(in_order_params)

    respond_to do |format|
      if @in_order.save
        format.html { redirect_to @in_order, notice: 'In order was successfully created.' }
        format.json { render :show, status: :created, location: @in_order }
      else
        format.html { render :new }
        format.json { render json: @in_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /in_orders/1
  # PATCH/PUT /in_orders/1.json
  def update
    respond_to do |format|
      if @in_order.update(in_order_params)
        format.html { redirect_to @in_order, notice: 'In order was successfully updated.' }
        format.json { render :show, status: :ok, location: @in_order }
      else
        format.html { render :edit }
        format.json { render json: @in_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /in_orders/1
  # DELETE /in_orders/1.json
  def destroy
    @in_order.destroy
    respond_to do |format|
      format.html { redirect_to in_orders_url, notice: 'In order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_in_order
    @in_order = InOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def in_order_params
    params.require(:in_order).permit(:Order_id, :GoDown_id, :InOrderId, :Name, :Type, :CreateTime, :CreateUser, :ExecTime, :Execer, :State)
  end
end
