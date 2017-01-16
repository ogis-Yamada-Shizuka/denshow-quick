class ForMatchingDatas::ModelCodeController < ApplicationController
  def index
    @q = ForMatchingData.ransack(params[:q])
    @for_matching_datas = params[:q].present? ? @q.result.group(:model_code).order(model_code: :ASC) : []
  end

  def destroy
  end
end
