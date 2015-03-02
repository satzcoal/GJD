require 'test_helper'

class OrderItemHisControllerTest < ActionController::TestCase
  setup do
    @order_item_hi = order_item_his(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_item_his)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_item_hi" do
    assert_difference('OrderItemHi.count') do
      post :create, order_item_hi: { BaseOrder_id: @order_item_hi.BaseOrder_id, BasePrice: @order_item_hi.BasePrice, BatchId: @order_item_hi.BatchId, CreateTime: @order_item_hi.CreateTime, Discount: @order_item_hi.Discount, ExceDate: @order_item_hi.ExceDate, ExceUser: @order_item_hi.ExceUser, GoDown_id: @order_item_hi.GoDown_id, Item_id: @order_item_hi.Item_id, SalPrice: @order_item_hi.SalPrice, Sum: @order_item_hi.Sum }
    end

    assert_redirected_to order_item_hi_path(assigns(:order_item_hi))
  end

  test "should show order_item_hi" do
    get :show, id: @order_item_hi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_item_hi
    assert_response :success
  end

  test "should update order_item_hi" do
    patch :update, id: @order_item_hi, order_item_hi: { BaseOrder_id: @order_item_hi.BaseOrder_id, BasePrice: @order_item_hi.BasePrice, BatchId: @order_item_hi.BatchId, CreateTime: @order_item_hi.CreateTime, Discount: @order_item_hi.Discount, ExceDate: @order_item_hi.ExceDate, ExceUser: @order_item_hi.ExceUser, GoDown_id: @order_item_hi.GoDown_id, Item_id: @order_item_hi.Item_id, SalPrice: @order_item_hi.SalPrice, Sum: @order_item_hi.Sum }
    assert_redirected_to order_item_hi_path(assigns(:order_item_hi))
  end

  test "should destroy order_item_hi" do
    assert_difference('OrderItemHi.count', -1) do
      delete :destroy, id: @order_item_hi
    end

    assert_redirected_to order_item_his_path
  end
end
