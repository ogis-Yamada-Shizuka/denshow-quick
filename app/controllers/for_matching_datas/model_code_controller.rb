class ForMatchingDatas::ModelCodeController < ApplicationController
  def index
    @q = ForMatchingData.ransack(params[:q])
    @model_codes = @q.result.order(model_code: :ASC).pluck(:model_code).uniq
  end

  def destroy
    ForMatchingData.destroy_all(model_code: params[:model_code])
    # TODO: ymlにnoticeメッセージを移植する
    flash[:notice] = '突合せデータを機種コードにもとづいて一括削除しました。'
    redirect_to for_matching_datas_model_code_path
  end
end
