module ApplicationHelper
  def current_views_request_detail_is_deletable?
    !(controller_name == 'request_applications' && action_name == 'edit')
  end
end
