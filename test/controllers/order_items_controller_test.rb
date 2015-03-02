require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  setup do
    @order_item = order_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post :create, order_item: { BaseOrder_id: @order_item.BaseOrder_id, BasePrice: @order_item.BasePrice, BatchId: @order_item.BatchId, CreateTime: @order_item.CreateTime, Discount: @order_item.Discount, GoDown_id: @order_item.GoDown_id, Item_id: @order_item.Item_id, SalPrice: @order_item.SalPrice, Sum: @order_item.Sum }
    end

    assert_redirected_to order_item_path(assigns(:order_item))
  end

  test "should show order_item" do
    get :show, id: @order_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_item
    assert_response :success
  end

  test "should update order_item" do
    patch :update, id: @order_item, order_item: { BaseOrder_id: @order_item.BaseOrder_id, BasePrice: @order_item.BasePrice, BatchId: @order_item.BatchId, CreateTime: @order_item.CreateTime, Discount: @order_item.Discount, GoDown_id: @order_item.GoDown_id, Item_id: @order_item.Item_id, SalPrice: @order_item.SalPrice, Sum: @order_item.Sum }
    assert_redirected_to order_item_path(assigns(:order_item))
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: @order_item
    end

    assert_redirected_to order_items_path
  end
end
