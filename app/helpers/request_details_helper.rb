module RequestDetailsHelper
  def append_error_class(object, attirbute_name)
    'alert-danger' if object.errors.key?(attirbute_name)
  end
end
