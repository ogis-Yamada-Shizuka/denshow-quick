module ApplicationHelper
  def from_edit_request_application?
    controller_name == 'request_applications' && action_name == 'edit'
  end
end
