class Info::ProviderFinDtlsController < ApplicationController
  before_action :set_info_provider_fin_dtl, only: [:show, :edit, :update, :destroy, :proceed]
  before_action :set_info_provider, only: [:new_with_provider, :index_with_provider]
  after_action :pre_save_proceed, only: [:create, :update]

  # GET /info/provider_fin_dtls
  # GET /info/provider_fin_dtls.json
  def index
    @info_provider_fin_dtls = Info::ProviderFinDtl.all
  end

  # GET /info/provider_fin_dtls/1
  # GET /info/provider_fin_dtls/1.json
  def show
    @info_provider = @info_provider_fin_dtl.finance.provider
  end

  # GET /info/provider_fin_dtls/new
  def new
    @info_provider_fin_dtl = Info::ProviderFinDtl.new
  end

  # GET /info/provider_fin_dtls/1/edit
  def edit
    @info_provider = @info_provider_fin_dtl.finance.provider
  end

  # POST /info/provider_fin_dtls
  # POST /info/provider_fin_dtls.json
  def create
    @info_provider_fin_dtl = Info::ProviderFinDtl.new(info_provider_fin_dtl_params)
    @info_provider_fin_dtl.status_id = 0
    respond_to do |format|
      if @info_provider_fin_dtl.save
        format.html { redirect_to @info_provider_fin_dtl, notice: 'Provider fin dtl was successfully created.' }
        format.json { render :show, status: :created, location: @info_provider_fin_dtl }
      else
        format.html { render :new }
        format.json { render json: @info_provider_fin_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /info/provider_fin_dtls/1
  # PATCH/PUT /info/provider_fin_dtls/1.json
  def update
    respond_to do |format|
      if @info_provider_fin_dtl.update(info_provider_fin_dtl_params)
        format.html { redirect_to @info_provider_fin_dtl, notice: 'Provider fin dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @info_provider_fin_dtl }
      else
        format.html { render :edit }
        format.json { render json: @info_provider_fin_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info/provider_fin_dtls/1
  # DELETE /info/provider_fin_dtls/1.json
  def destroy
    @info_provider_fin_dtl.status_id = 2
    respond_to do |format|
      @info_provider_fin_dtl.save
      format.html { redirect_to @info_provider_fin_dtl }
      format.json { render :show, status: :ok, location: @info_provider_fin_dtl }
    end
  end

  def new_with_provider
    @info_provider_fin_dtl = @info_provider.finance.fin_dtls.build
  end

  def index_with_provider
    @info_provider_fin_dtls = @info_provider.finance.fin_dtls
  end

  def proceed
    @info_provider_fin_dtl.proceed
    redirect_to :back
  end

  def pre_save_proceed
    if params[:save] == nil #proceed
      @info_provider_fin_dtl.proceed
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_info_provider_fin_dtl
    @info_provider_fin_dtl = Info::ProviderFinDtl.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def info_provider_fin_dtl_params
    params.require(:info_provider_fin_dtl).permit(:fin_id, :do_time, :in_or_out, :money, :cfd_id, :status_id, :proceed, :save, :comment)
  end

  def set_info_provider
    @info_provider = Info::Provider.find(params[:id])
  end
end
