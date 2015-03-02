require 'test_helper'

class ItemOutOrdersControllerTest < ActionController::TestCase
  setup do
    @item_out_order = item_out_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_out_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_out_order" do
    assert_difference('ItemOutOrder.count') do
      post :create, item_out_order: { id: @item_out_order.id }
    end

    assert_redirected_to item_out_order_path(assigns(:item_out_order))
  end

  test "should show item_out_order" do
    get :show, id: @item_out_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_out_order
    assert_response :success
  end

  test "should update item_out_order" do
    patch :update, id: @item_out_order, item_out_order: { id: @item_out_order.id }
    assert_redirected_to item_out_order_path(assigns(:item_out_order))
  end

  test "should destroy item_out_order" do
    assert_difference('ItemOutOrder.count', -1) do
      delete :destroy, id: @item_out_order
    end

    assert_redirected_to item_out_orders_path
  end
end
