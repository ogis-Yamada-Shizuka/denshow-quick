module RequestDetailsHelper
  def append_error_class(object, attirbute_name)
    'alert-danger' if object.errors.key?(attirbute_name)
  end

  def generate_edit_detail_link(link_name, request_application_id, detail_id)
    return if link_name.blank?
    link_to(link_name, edit_request_application_request_detail_path(request_application_id, detail_id), class: 'edit-link')
  end
end
