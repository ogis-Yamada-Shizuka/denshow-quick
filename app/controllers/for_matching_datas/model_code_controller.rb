class ForMatchingDatas::ModelCodeController < ApplicationController
  def index
    @q = ForMatchingData.ransack(params[:q])
    @for_matching_datas = params[:q].present? ? @q.result.group(:model_code).order(model_code: :ASC) : []
  end

  def destroy
    ForMatchingData.destroy_all(model_code: params[:model_code])
    flash[:notice] = 'For matching datas model code was successfully destroyed.'
    redirect_to for_matching_datas_model_code_path
  end
end
