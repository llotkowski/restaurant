require 'test_helper'

class CuisinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuisines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuisine" do
    assert_difference('Cuisine.count') do
      post :create, :cuisine => { }
    end

    assert_redirected_to cuisine_path(assigns(:cuisine))
  end

  test "should show cuisine" do
    get :show, :id => cuisines(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cuisines(:one).id
    assert_response :success
  end

  test "should update cuisine" do
    put :update, :id => cuisines(:one).id, :cuisine => { }
    assert_redirected_to cuisine_path(assigns(:cuisine))
  end

  test "should destroy cuisine" do
    assert_difference('Cuisine.count', -1) do
      delete :destroy, :id => cuisines(:one).id
    end

    assert_redirected_to cuisines_path
  end
end
