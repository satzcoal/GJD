require 'test_helper'

class WorkShopsControllerTest < ActionController::TestCase
  setup do
    @work_shop = work_shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_shop" do
    assert_difference('WorkShop.count') do
      post :create, work_shop: { address: @work_shop.address, admin: @work_shop.admin, name: @work_shop.name }
    end

    assert_redirected_to work_shop_path(assigns(:work_shop))
  end

  test "should show work_shop" do
    get :show, id: @work_shop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_shop
    assert_response :success
  end

  test "should update work_shop" do
    patch :update, id: @work_shop, work_shop: { address: @work_shop.address, admin: @work_shop.admin, name: @work_shop.name }
    assert_redirected_to work_shop_path(assigns(:work_shop))
  end

  test "should destroy work_shop" do
    assert_difference('WorkShop.count', -1) do
      delete :destroy, id: @work_shop
    end

    assert_redirected_to work_shops_path
  end
end
