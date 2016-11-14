class FlowOrdersController < ApplicationController
  before_action :set_flow_order, only: [:show, :edit, :update, :destroy]

  # GET /flow_orders
  # GET /flow_orders.json
  def index
    @flow_orders = FlowOrder.all
  end

  # GET /flow_orders/1
  # GET /flow_orders/1.json
  def show
  end

  # GET /flow_orders/new
  def new
    @flow_order = FlowOrder.new
  end

  # GET /flow_orders/1/edit
  def edit
  end

  # POST /flow_orders
  # POST /flow_orders.json
  def create
    @flow_order = FlowOrder.new(flow_order_params)

    respond_to do |format|
      if @flow_order.save
        format.html { redirect_to @flow_order, notice: 'Flow order was successfully created.' }
        format.json { render :show, status: :created, location: @flow_order }
      else
        format.html { render :new }
        format.json { render json: @flow_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flow_orders/1
  # PATCH/PUT /flow_orders/1.json
  def update
    respond_to do |format|
      if @flow_order.update(flow_order_params)
        format.html { redirect_to @flow_order, notice: 'Flow order was successfully updated.' }
        format.json { render :show, status: :ok, location: @flow_order }
      else
        format.html { render :edit }
        format.json { render json: @flow_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flow_orders/1
  # DELETE /flow_orders/1.json
  def destroy
    @flow_order.destroy
    respond_to do |format|
      format.html { redirect_to flow_orders_url, notice: 'Flow order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flow_order
    @flow_order = FlowOrder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def flow_order_params
    params.require(:flow_order).permit(:order, :project_flg, :dept_id, :reject_permission, :first_to_revert_permission)
  end
end
