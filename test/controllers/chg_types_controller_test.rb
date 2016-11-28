require 'test_helper'

class ChgTypesControllerTest < ActionController::TestCase
  setup do
    @chg_type = chg_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chg_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chg_type" do
    assert_difference('ChgType.count') do
      post :create, chg_type: { name: @chg_type.name }
    end

    assert_redirected_to chg_type_path(assigns(:chg_type))
  end

  test "should show chg_type" do
    get :show, id: @chg_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chg_type
    assert_response :success
  end

  test "should update chg_type" do
    patch :update, id: @chg_type, chg_type: { name: @chg_type.name }
    assert_redirected_to chg_type_path(assigns(:chg_type))
  end

  test "should destroy chg_type" do
    assert_difference('ChgType.count', -1) do
      delete :destroy, id: @chg_type
    end

    assert_redirected_to chg_types_path
  end
end
