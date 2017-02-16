module RequestApplicationsHelper
  def link_to_edit_detail_path(name, detail)
    return if name.blank?
    link_to name, edit_request_application_request_detail_path(detail.request_application, detail), class: 'edit-link'
  end

  def render_attributes(model_code, object)
    safe_join(object.compare_attributes.values.delete_if(&:blank?).unshift(model_code), '|')
  end

  def render_unmatched_attributes(model_code, detail, unmatched_attributes)
    safe_join(
      detail.compare_attributes.map do |key, value|
        if unmatched_attributes.include?(key)
          render_unmatched_attribute(value)
        else
          value.present? ? value : nil
        end
      end.compact.unshift(model_code), '|'
    )
  end

  def render_unmatched_attribute(value)
    content_tag(:span, value.present? ? value : '？', class: 'unmatch')
  end
end
