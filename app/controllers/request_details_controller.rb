class RequestDetailsController < ApplicationController
  before_action :set_request_detail, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @request_application = RequestApplication.find(params[:request_application_id])
    @request_detail = @request_application.details.build
  end

  def edit
  end

  def create
    @request_detail = RequestDetail.new(request_detail_params)
    if @request_detail.save
      change_redirect_to_by_commit_message
    else
      @request_application = @request_detail.request_application
      render :new
    end
  end

  def update
    if @request_detail.update(request_detail_params)
      change_redirect_to_by_commit_message
    else
      @request_application = @request_detail.request_application
      render :edit
    end
  end

  def destroy
    @request_detail.destroy
    redirect_to request_applications_url, notice: 'Request detail was successfully destroyed.'
  end

  private

  def set_request_detail
    @request_detail = RequestDetail.find(params[:id])
  end

  def request_detail_params
    params.require(:request_detail).permit(
      :request_application_id, :doc_no, :doc_type_id, :sht, :rev, :eo_chgno, :chg_type_id, :mcl, :scp_for_smpl, :scml_ln
    )
  end

  def change_redirect_to_by_commit_message
    if params[:save_and_insert].present?
      redirect_to new_request_application_request_detail_path(@request_detail.request_application), notice: redirect_notice_message
    else
      redirect_to request_application_request_detail_path(@request_detail.request_application, @request_detail), notice: redirect_notice_message
    end
  end

  def redirect_notice_message
    if action_name == 'create'
      'Request detail was successfully created.'
    else
      'Request detail was successfully updated.'
    end
  end
end
