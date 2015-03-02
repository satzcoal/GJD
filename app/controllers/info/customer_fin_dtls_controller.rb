class Info::CustomerFinDtlsController < ApplicationController
  before_action :set_info_customer_fin_dtl, only: [:show, :edit, :update, :destroy, :proceed]
  before_action :set_info_customer, only: [:new_with_customer, :index_with_customer]
  after_action :pre_save_proceed, only: [:create, :update]

  # GET /info/customer_fin_dtls
  # GET /info/customer_fin_dtls.json
  def index
    @info_customer_fin_dtls = Info::CustomerFinDtl.all
  end

  # GET /info/customer_fin_dtls/1
  # GET /info/customer_fin_dtls/1.json
  def show
    @info_customer = @info_customer_fin_dtl.finance.customer
  end

  # GET /info/customer_fin_dtls/new
  def new
    @info_customer_fin_dtl = Info::CustomerFinDtl.new
  end

  # GET /info/customer_fin_dtls/1/edit
  def edit
    @info_customer = @info_customer_fin_dtl.finance.customer
  end

  # POST /info/customer_fin_dtls
  # POST /info/customer_fin_dtls.json
  def create
    @info_customer_fin_dtl = Info::CustomerFinDtl.new(info_customer_fin_dtl_params)
    @info_customer_fin_dtl.status_id = 0
    respond_to do |format|
      if @info_customer_fin_dtl.save
        format.html { redirect_to @info_customer_fin_dtl, notice: 'Customer fin dtl was successfully created.' }
        format.json { render :show, status: :created, location: @info_customer_fin_dtl }
      else
        format.html { render :new }
        format.json { render json: @info_customer_fin_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /info/customer_fin_dtls/1
  # PATCH/PUT /info/customer_fin_dtls/1.json
  def update
    respond_to do |format|
      if @info_customer_fin_dtl.update(info_customer_fin_dtl_params)
        format.html { redirect_to @info_customer_fin_dtl, notice: 'Customer fin dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @info_customer_fin_dtl }
      else
        format.html { render :edit }
        format.json { render json: @info_customer_fin_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info/customer_fin_dtls/1
  # DELETE /info/customer_fin_dtls/1.json
  def destroy
    @info_customer_fin_dtl.status_id = 2
    respond_to do |format|
      @info_customer_fin_dtl.save
      format.html { redirect_to @info_customer_fin_dtl }
      format.json { render :show, status: :ok, location: @info_customer_fin_dtl }
    end
  end

  def new_with_customer
    @info_customer_fin_dtl = @info_customer.finance.fin_dtls.build
  end

  def index_with_customer
    @info_customer_fin_dtls = @info_customer.finance.fin_dtls
  end

  def proceed
    @info_customer_fin_dtl.proceed
    redirect_to :back
  end

  def pre_save_proceed
    if params[:save] == nil #proceed
      @info_customer_fin_dtl.proceed
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_info_customer_fin_dtl
    @info_customer_fin_dtl = Info::CustomerFinDtl.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def info_customer_fin_dtl_params
    params.require(:info_customer_fin_dtl).permit(:fin_id, :do_time, :in_or_out, :money, :cfd_id, :status_id, :proceed, :save, :comment)
  end

  def set_info_customer
    @info_customer = Info::Customer.find(params[:id])
  end
end
