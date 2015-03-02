class BillhisController < ApplicationController
  before_action :set_billhi, only: [:show, :edit, :update, :destroy]

  # GET /billhis
  # GET /billhis.json
  def index
    @billhis = Billhi.all
  end

  # GET /billhis/1
  # GET /billhis/1.json
  def show
  end

  # GET /billhis/new
  def new
    @billhi = Billhi.new
  end

  # GET /billhis/1/edit
  def edit
  end

  # POST /billhis
  # POST /billhis.json
  def create
    @billhi = Billhi.new(billhi_params)

    respond_to do |format|
      if @billhi.save
        format.html { redirect_to @billhi, notice: 'Billhi was successfully created.' }
        format.json { render :show, status: :created, location: @billhi }
      else
        format.html { render :new }
        format.json { render json: @billhi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /billhis/1
  # PATCH/PUT /billhis/1.json
  def update
    respond_to do |format|
      if @billhi.update(billhi_params)
        format.html { redirect_to @billhi, notice: 'Billhi was successfully updated.' }
        format.json { render :show, status: :ok, location: @billhi }
      else
        format.html { render :edit }
        format.json { render json: @billhi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billhis/1
  # DELETE /billhis/1.json
  def destroy
    @billhi.destroy
    respond_to do |format|
      format.html { redirect_to billhis_url, notice: 'Billhi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billhi
      @billhi = Billhi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billhi_params
      params.require(:billhi).permit(:BaseOrder_id, :Total, :From, :FromAddress, :From_Back, :From_BackAccountNum, :From_BackAccountName, :To, :ToAddress, :To_Back, :To_BackAccountNum, :To_BackAccountName, :ExceTime, :ExceUser)
    end
end
