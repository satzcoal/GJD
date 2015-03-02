require 'test_helper'

class BaseOrdersControllerTest < ActionController::TestCase
  setup do
    @base_order = base_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_order" do
    assert_difference('BaseOrder.count') do
      post :create, base_order: { CreateTime: @base_order.CreateTime, CreateUser: @base_order.CreateUser, FactTotal: @base_order.FactTotal, From: @base_order.From, FromAddress: @base_order.FromAddress, From_Back: @base_order.From_Back, From_BackAccountName: @base_order.From_BackAccountName, From_BackAccountNum: @base_order.From_BackAccountNum, MoneyState: @base_order.MoneyState, OrderId: @base_order.OrderId, State: @base_order.State, To: @base_order.To, ToAddress: @base_order.ToAddress, To_Back: @base_order.To_Back, To_BackAccountName: @base_order.To_BackAccountName, To_BackAccountNum: @base_order.To_BackAccountNum, Total: @base_order.Total, type: @base_order.type }
    end

    assert_redirected_to base_order_path(assigns(:base_order))
  end

  test "should show base_order" do
    get :show, id: @base_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @base_order
    assert_response :success
  end

  test "should update base_order" do
    patch :update, id: @base_order, base_order: { CreateTime: @base_order.CreateTime, CreateUser: @base_order.CreateUser, FactTotal: @base_order.FactTotal, From: @base_order.From, FromAddress: @base_order.FromAddress, From_Back: @base_order.From_Back, From_BackAccountName: @base_order.From_BackAccountName, From_BackAccountNum: @base_order.From_BackAccountNum, MoneyState: @base_order.MoneyState, OrderId: @base_order.OrderId, State: @base_order.State, To: @base_order.To, ToAddress: @base_order.ToAddress, To_Back: @base_order.To_Back, To_BackAccountName: @base_order.To_BackAccountName, To_BackAccountNum: @base_order.To_BackAccountNum, Total: @base_order.Total, type: @base_order.type }
    assert_redirected_to base_order_path(assigns(:base_order))
  end

  test "should destroy base_order" do
    assert_difference('BaseOrder.count', -1) do
      delete :destroy, id: @base_order
    end

    assert_redirected_to base_orders_path
  end
end
