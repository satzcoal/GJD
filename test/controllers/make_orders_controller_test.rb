require 'test_helper'

class MakeOrdersControllerTest < ActionController::TestCase
  setup do
    @make_order = make_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:make_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create make_order" do
    assert_difference('MakeOrder.count') do
      post :create, make_order: { id: @make_order.id }
    end

    assert_redirected_to make_order_path(assigns(:make_order))
  end

  test "should show make_order" do
    get :show, id: @make_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @make_order
    assert_response :success
  end

  test "should update make_order" do
    patch :update, id: @make_order, make_order: { id: @make_order.id }
    assert_redirected_to make_order_path(assigns(:make_order))
  end

  test "should destroy make_order" do
    assert_difference('MakeOrder.count', -1) do
      delete :destroy, id: @make_order
    end

    assert_redirected_to make_orders_path
  end
end
