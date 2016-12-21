class RequestApplications::MatchingController < ApplicationController
  # TODO: 突き合わせ用データとのマッチング処理はsp03で実装する
  def matching
    @q = RequestApplication.ransack(params[:q])
  end

  def mathcing_result; end
end
