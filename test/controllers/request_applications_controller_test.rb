require 'test_helper'

class RequestApplicationsControllerTest < ActionController::TestCase
  setup do
    @request_application = request_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_application" do
    assert_difference('RequestApplication.count') do
      post :create, request_application: { close: @request_application.close, emargency: @request_application.emargency, filename: @request_application.filename, management_no: @request_application.management_no, preferred_date: @request_application.preferred_date, request_date: @request_application.request_date }
    end

    assert_redirected_to request_application_path(assigns(:request_application))
  end

  test "should show request_application" do
    get :show, id: @request_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_application
    assert_response :success
  end

  test "should update request_application" do
    patch :update, id: @request_application, request_application: { close: @request_application.close, emargency: @request_application.emargency, filename: @request_application.filename, management_no: @request_application.management_no, preferred_date: @request_application.preferred_date, request_date: @request_application.request_date }
    assert_redirected_to request_application_path(assigns(:request_application))
  end

  test "should destroy request_application" do
    assert_difference('RequestApplication.count', -1) do
      delete :destroy, id: @request_application
    end

    assert_redirected_to request_applications_path
  end
end
