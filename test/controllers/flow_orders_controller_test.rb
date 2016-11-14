require 'test_helper'

class FlowOrdersControllerTest < ActionController::TestCase
  setup do
    @flow_order = flow_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flow_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flow_order" do
    assert_difference('FlowOrder.count') do
      post :create, flow_order: { dept_id: @flow_order.dept_id, order: @flow_order.order, project_flg: @flow_order.project_flg }
    end

    assert_redirected_to flow_order_path(assigns(:flow_order))
  end

  test "should show flow_order" do
    get :show, id: @flow_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flow_order
    assert_response :success
  end

  test "should update flow_order" do
    patch :update, id: @flow_order, flow_order: { dept_id: @flow_order.dept_id, order: @flow_order.order, project_flg: @flow_order.project_flg }
    assert_redirected_to flow_order_path(assigns(:flow_order))
  end

  test "should destroy flow_order" do
    assert_difference('FlowOrder.count', -1) do
      delete :destroy, id: @flow_order
    end

    assert_redirected_to flow_orders_path
  end
end
