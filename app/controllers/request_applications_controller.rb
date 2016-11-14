class RequestApplicationsController < ApplicationController
  before_action :set_request_application, only: [:show, :edit, :update, :destroy, :regist, :reject, :interrupt, :first_to_revert, :regist_memo, :reject_memo, :interrupt_memo, :first_to_revert_memo]
  before_action :set_vendor_id, only: [:update]
  before_action :set_memo, only: [:regist, :reject, :interrupt, :first_to_revert]

  # GET /request_applications
  # GET /request_applications.json
  def index
    #    @request_applications = RequestApplication.all.order(:created_at).reverse_order
    @q = RequestApplication.ransack(params[:q])
    @request_applications = @q.result.order(:created_at).reverse_order

    @flow_orders = FlowOrder.order_list
  end

  # GET /request_applications/1
  # GET /request_applications/1.json
  def show
  end

  # GET /request_applications/new
  def new
    @request_application = RequestApplication.new
  end

  # GET /request_applications/1/edit
  def edit
  end

  # POST /request_applications
  # POST /request_applications.json
  def create
    @request_application = RequestApplication.new(request_application_params)
    flow = @request_application.flows.build
    # 初期フロー生成
    flow.init_flow
    @request_application.vendor_setting

    respond_to do |format|
      if @request_application.save && flow.save
        format.html { redirect_to @request_application, notice: 'Request application was successfully created.' }
        format.json { render :show, status: :created, location: @request_application }
      else
        format.html { render :new }
        format.json { render json: @request_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_applications/1
  # PATCH/PUT /request_applications/1.json
  def update
    respond_to do |format|
      if @request_application.update(request_application_params) && set_vendor_id
        format.html { redirect_to @request_application, notice: 'Request application was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_application }
      else
        format.html { render :edit }
        format.json { render json: @request_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_applications/1
  # DELETE /request_applications/1.json
  def destroy
    @request_application.destroy
    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def regist
    # 最新flowのprogressを生成する。（進捗を進める）
    @request_application.flows.last.set_memo(@memo)
    @request_application.flows.last.proceed

    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully progress changed.' }
      format.json { head :no_content }
    end
  end

  def reject
    # 最新flowのprogressを生成する。(進捗を戻す)
    @request_application.flows.last.set_memo(@memo)
    @request_application.flows.last.retreat

    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully progress changed.' }
      format.json { head :no_content }
    end
  end

  def interrupt
    # 要求書の処理を中断終了する
    @request_application.interrupt
    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully flow interrupted.' }
      format.json { head :no_content }
    end
  end

  def first_to_revert
    # フローの始めに戻す・。
    @request_application.flows.last.first_to_revert

    respond_to do |format|
      format.html { redirect_to request_applications_url, notice: 'Request application was successfully progress changed.' }
      format.json { head :no_content }
    end
  end

  def regist_memo
  end

  def reject_memo
  end

  def interrupt_memo
  end

  def first_to_return_memo
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request_application
    @request_application = RequestApplication.find(params[:id])
    begin
      @request_application.vendor_code = Vendor.find(@request_application.vendor_id).code
    rescue
      @request_application.vendor_code = nil
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_application_params
    params.require(:request_application).permit(:management_no, :emargency, :filename, :request_date, :preferred_date, :close, :project_id, :memo, :vendor_code, :model_id, :section_id, flow_attributes: [:memo])
  end

  def set_vendor_id
    @request_application.vendor_id = Vendor.find_by(code: params["request_application"]["vendor_code"]).try(:id)
    @request_application.save
  end

  def set_memo
    @memo = params[:flow][:memo].presence if params[:flow].present?
    @request_application.flows.last.set_memo(@memo)
  end
end
