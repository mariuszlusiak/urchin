require 'test_helper'

class Admin::SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @admin_subscription = admin_subscriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_subscription" do
    assert_difference('Admin::Subscription.count') do
      post :create, :admin_subscription => @admin_subscription.attributes
    end

    assert_redirected_to admin_subscription_path(assigns(:admin_subscription))
  end

  test "should show admin_subscription" do
    get :show, :id => @admin_subscription.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_subscription.to_param
    assert_response :success
  end

  test "should update admin_subscription" do
    put :update, :id => @admin_subscription.to_param, :admin_subscription => @admin_subscription.attributes
    assert_redirected_to admin_subscription_path(assigns(:admin_subscription))
  end

  test "should destroy admin_subscription" do
    assert_difference('Admin::Subscription.count', -1) do
      delete :destroy, :id => @admin_subscription.to_param
    end

    assert_redirected_to admin_subscriptions_path
  end
end
