class Flow < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :dept
  has_one :progress, dependent: :destroy
  #  scope :latest_flows, -> (request_application_id) { where(request_application_id: request_application_id).group(:order).having(" history_no= max(history_no)").order(:order) }
  scope :latest_flows, -> (latest_ids) { where(id: latest_ids).order(:order) }
  scope :current_flows, -> { group(:request_application_id).having(" history_no= max(history_no)") }

  # 初期フローを作成する。
  def init_flow
    first_order = FlowOrder.order_list.first
    self.order = first_order.order
    self.dept_id = first_order.dept_id
    self.history_no = 1
  end

  # 進捗を１つ進める
  def proceed
    # 進捗状況が紐付いていない時は、新たな進捗情報を作成する
    if progress.nil?
      Progress.new_flow(id)
    else
      progress.finished
      # 次のフローも合わせて生成。最後の時はcloseする。
      next_flow if FlowOrder.maximum('order') > order
      RequestApplication.closed(request_application_id) if FlowOrder.maximum('order') == order
    end
  end

  # 進捗を１つ戻す
  def retreat
    # 戻った直後の進捗は、進捗状況が新たに一つできる。
    Progress.new_flow(id)
    # 戻った直後のフローも合わせて生成。（１つフローが戻る）
    back_flow
  end

  # 進捗を最初に戻す
  def first_to_revert
    # 戻った直後の進捗は、進捗状況が新たに一つできる。
    Progress.new_flow(id)
    # 戻った直後のフローも合わせて生成。（最初にフローが戻る）
    first_flow
  end

  # 1つ前の差し戻しができるかどうか
  def reject?
    FlowOrder.find_by(order: order).reject_permission?
  end

  # 最初への差し戻しができるかどうか
  def first_to_revert?
    FlowOrder.find_by(order: order).first_to_revert_permission?
  end

  def self.latest_ids(request_application_id)
    flows = Flow.where(request_application_id: request_application_id).order(:order, :history_no).pluck(:order, :history_no, :id)
    flows_order = flows.group_by { |flow| flow[0] }
    latest_ids = []
    flows_order.each do |_order, fls|
      latest_id = fls.max_by { |f| f[1] }
      latest_ids.push(latest_id[2])
    end
    latest_ids
  end

  def self.current_ids(dept_id)
#    current_flows = Flow.current_flows.pluck(:request_application_id, :dept_id)
    flows = Flow.all.pluck(:request_application_id, :history_no, :dept_id)
    current_flows = flows.group_by { |flow| flow[0] }

    latest_ids = []

    targer_ids = []
    current_flows.each do |ra_id, fls|
      latest_id = fls.max_by { |f| f[1] }
      targer_ids.push(ra_id) if latest_id[2] == dept_id.to_i
    end
    targer_ids
  end

  def set_memo(memo)
    if memo.present?
      self.memo = memo
      save
    end
  end

  private

  # 次のフローへ進む
  def next_flow
    flow = Flow.new
    flow.request_application_id = request_application_id
    flow.order = order + 1
    flow.history_no = history_no + 1
    flow.dept_id = if FlowOrder.find_by(order: flow.order).project_flg
                     RequestApplication.find(request_application_id).project_id
                   else
                     FlowOrder.find_by(order: flow.order).dept_id
                   end
    flow.save
  end

  # 前のフローに戻る
  def back_flow
    flow = Flow.new
    flow.request_application_id = request_application_id
    flow.order = order - 1
    flow.history_no = history_no + 1
    flow.dept_id = if FlowOrder.find_by(order: flow.order).project_flg
                     RequestApplication.find(request_application_id).project_id
                   else
                     FlowOrder.find_by(order: flow.order).dept_id
                   end
    flow.save
  end

  # 一番最初のフローに戻る
  def first_flow
    flow = Flow.new
    flow.request_application_id = request_application_id
    flow.order = 1
    flow.history_no = history_no + 1
    flow.dept_id = if FlowOrder.find_by(order: flow.order).project_flg
                     RequestApplication.find(request_application_id).project_id
                   else
                     FlowOrder.find_by(order: flow.order).dept_id
                   end
    flow.save
  end
end
