class Progress < ActiveRecord::Base
  belongs_to :flow

  # 新たな進捗情報を作成する。
  def self.new_flow(flow_id)
    progress = Progress.new
    progress.flow_id = flow_id
    progress.in_date = Time.current
    progress.save
  end

  # 進捗完了とする （終了日時をセットする)
  def finished
    self.out_date = Time.current
    save
  end

  # 中断とする（開始日時と終了日時をセットする。開始日時はデータが入っていない場合のみ）
  def interrupted
    time = Time.current
    self.in_date = time if in_date.blank?
    self.out_date = time
    save
  end
end
