require 'test_helper'

class BillhisControllerTest < ActionController::TestCase
  setup do
    @billhi = billhis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:billhis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create billhi" do
    assert_difference('Billhi.count') do
      post :create, billhi: { BaseOrder_id: @billhi.BaseOrder_id, ExceTime: @billhi.ExceTime, ExceUser: @billhi.ExceUser, From: @billhi.From, FromAddress: @billhi.FromAddress, From_Back: @billhi.From_Back, From_BackAccountName: @billhi.From_BackAccountName, From_BackAccountNum: @billhi.From_BackAccountNum, To: @billhi.To, ToAddress: @billhi.ToAddress, To_Back: @billhi.To_Back, To_BackAccountName: @billhi.To_BackAccountName, To_BackAccountNum: @billhi.To_BackAccountNum, Total: @billhi.Total }
    end

    assert_redirected_to billhi_path(assigns(:billhi))
  end

  test "should show billhi" do
    get :show, id: @billhi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @billhi
    assert_response :success
  end

  test "should update billhi" do
    patch :update, id: @billhi, billhi: { BaseOrder_id: @billhi.BaseOrder_id, ExceTime: @billhi.ExceTime, ExceUser: @billhi.ExceUser, From: @billhi.From, FromAddress: @billhi.FromAddress, From_Back: @billhi.From_Back, From_BackAccountName: @billhi.From_BackAccountName, From_BackAccountNum: @billhi.From_BackAccountNum, To: @billhi.To, ToAddress: @billhi.ToAddress, To_Back: @billhi.To_Back, To_BackAccountName: @billhi.To_BackAccountName, To_BackAccountNum: @billhi.To_BackAccountNum, Total: @billhi.Total }
    assert_redirected_to billhi_path(assigns(:billhi))
  end

  test "should destroy billhi" do
    assert_difference('Billhi.count', -1) do
      delete :destroy, id: @billhi
    end

    assert_redirected_to billhis_path
  end
end
