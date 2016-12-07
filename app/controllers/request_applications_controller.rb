class RequestApplicationsController < ApplicationController
  before_action :set_request_application, only: %i(
    show edit update destroy regist reject interrupt first_to_revert regist_memo reject_memo interrupt_memo first_to_revert_memo registration_result
  )
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
  def show; end

  # GET /request_applications/new
  def new
    @request_application = RequestApplication.new
  end

  # GET /request_applications/1/edit
  def edit; end

  # POST /request_applications
  # POST /request_applications.json
  def create
    @request_application = RequestApplication.new(request_application_params)
    flow = @request_application.flows.build
    # 初期フロー生成
    flow.init_flow
    respond_to do |format|
      if @request_application.save && flow.save
        format.html { change_redirect_to_by_commit_message }
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
      if @request_application.update(request_application_params)
        format.html { change_redirect_to_by_commit_message }
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

  def regist_memo; end

  def reject_memo; end

  def interrupt_memo; end

  def first_to_return_memo; end

  # TODO: NotRecord Foundのエラー処理の際にリファクタする
  def import_excel
    @request_application = RequestApplicationImportExcel.import(params[:file].tempfile)
    flow = @request_application.flows.build
    flow.init_flow
    if @request_application.save
      redirect_to request_applications_path, notice: 'request imported.'
    else
      render :import_excel
    end
  rescue
    redirect_to request_applications_path, notice: 'import failed.'
  end

  def registration_result; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request_application
    @request_application = RequestApplication.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_application_params
    params.require(:request_application).permit(
      :management_no, :emargency, :filename, :request_date, :preferred_date, :close, :project_id, :memo, :model_id, :section_id,
      flow_attributes: [:memo]
    )
  end

  def set_memo
    @memo = params[:flow][:memo].presence if params[:flow].present?
    @request_application.flows.last.set_memo(@memo)
  end

  def change_redirect_to_by_commit_message
    if params[:save_and_insert].present?
      redirect_to new_request_application_request_detail_path(@request_application), notice: redirect_notice_message
    else
      redirect_to @request_application, notice: redirect_notice_message
    end
  end

  def redirect_notice_message
    if action_name == 'create'
      'Request application was successfully created.'
    else
      'Request application was successfully updated.'
    end
  end
end
