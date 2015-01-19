require 'test_helper'

module Hawk
  class HawkersControllerTest < ActionController::TestCase
    setup do
      @hawker = hawkers(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:hawkers)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create hawker" do
      assert_difference('Hawker.count') do
        post :create, hawker: {  }
      end
  
      assert_redirected_to hawker_path(assigns(:hawker))
    end
  
    test "should show hawker" do
      get :show, id: @hawker
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @hawker
      assert_response :success
    end
  
    test "should update hawker" do
      put :update, id: @hawker, hawker: {  }
      assert_redirected_to hawker_path(assigns(:hawker))
    end
  
    test "should destroy hawker" do
      assert_difference('Hawker.count', -1) do
        delete :destroy, id: @hawker
      end
  
      assert_redirected_to hawkers_path
    end
  end
end
