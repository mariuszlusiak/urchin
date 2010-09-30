require 'test_helper'

class Admin::PackagesControllerTest < ActionController::TestCase
  setup do
    @admin_package = admin_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_package" do
    assert_difference('Admin::Package.count') do
      post :create, :admin_package => @admin_package.attributes
    end

    assert_redirected_to admin_package_path(assigns(:admin_package))
  end

  test "should show admin_package" do
    get :show, :id => @admin_package.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_package.to_param
    assert_response :success
  end

  test "should update admin_package" do
    put :update, :id => @admin_package.to_param, :admin_package => @admin_package.attributes
    assert_redirected_to admin_package_path(assigns(:admin_package))
  end

  test "should destroy admin_package" do
    assert_difference('Admin::Package.count', -1) do
      delete :destroy, :id => @admin_package.to_param
    end

    assert_redirected_to admin_packages_path
  end
end
