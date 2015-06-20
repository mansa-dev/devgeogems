require 'test_helper'

class TriviaItemsControllerTest < ActionController::TestCase
  setup do
    @trivia_item = trivia_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trivia_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trivia_item" do
    assert_difference('TriviaItem.count') do
      post :create, :trivia_item => @trivia_item.attributes
    end

    assert_redirected_to trivia_item_path(assigns(:trivia_item))
  end

  test "should show trivia_item" do
    get :show, :id => @trivia_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @trivia_item.to_param
    assert_response :success
  end

  test "should update trivia_item" do
    put :update, :id => @trivia_item.to_param, :trivia_item => @trivia_item.attributes
    assert_redirected_to trivia_item_path(assigns(:trivia_item))
  end

  test "should destroy trivia_item" do
    assert_difference('TriviaItem.count', -1) do
      delete :destroy, :id => @trivia_item.to_param
    end

    assert_redirected_to trivia_items_path
  end
end
