class ForMatchingDatas::ModelCodeController < ApplicationController
  def index
    @q = ForMatchingData.ransack(params[:q])
    @model_codes = @q.result.group(:model_code).order(model_code: :ASC).pluck(:model_code)
  end

  def destroy
    ForMatchingData.destroy_all(model_code: params[:model_code])
    flash[:notice] = t('message.template.delete.for_matching_data_by_model_code', model_code: params[:model_code])
    redirect_to for_matching_datas_model_code_path
  end
end
