module RequestApplicationsHelper
  # TODO: 一致・不一致の部分をymlに定義する
  def render_matching_result_table_data(is_match)
    if is_match
      content_tag(:td, '一致')
    else
      content_tag(:td, '不一致', style: "color: red;")
    end
  end
end
