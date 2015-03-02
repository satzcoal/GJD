class WorkShopsController < ApplicationController
  before_action :set_work_shop, only: [:show, :edit, :update, :destroy]

  # GET /work_shops
  # GET /work_shops.json
  def index
    @work_shops = WorkShop.all
  end

  # GET /work_shops/1
  # GET /work_shops/1.json
  def show
  end

  # GET /work_shops/new
  def new
    @work_shop = WorkShop.new
  end

  # GET /work_shops/1/edit
  def edit
  end

  # POST /work_shops
  # POST /work_shops.json
  def create
    @work_shop = WorkShop.new(work_shop_params)

    respond_to do |format|
      if @work_shop.save
        format.html { redirect_to @work_shop, notice: 'Work shop was successfully created.' }
        format.json { render :show, status: :created, location: @work_shop }
      else
        format.html { render :new }
        format.json { render json: @work_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_shops/1
  # PATCH/PUT /work_shops/1.json
  def update
    respond_to do |format|
      if @work_shop.update(work_shop_params)
        format.html { redirect_to @work_shop, notice: 'Work shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_shop }
      else
        format.html { render :edit }
        format.json { render json: @work_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_shops/1
  # DELETE /work_shops/1.json
  def destroy
    @work_shop.destroy
    respond_to do |format|
      format.html { redirect_to work_shops_url, notice: 'Work shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_shop
      @work_shop = WorkShop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_shop_params
      params.require(:work_shop).permit(:name, :address, :admin)
    end
end
