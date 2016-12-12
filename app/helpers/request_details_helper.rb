module RequestDetailsHelper
  def append_error_class(model, attirbute_sym)
    'alert-danger' if model.errors.key?(attirbute_sym)
  end
end
