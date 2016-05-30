require 'test_helper'

class QacommentsControllerTest < ActionController::TestCase
  setup do
    @qacomment = qacomments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qacomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qacomment" do
    assert_difference('Qacomment.count') do
      post :create, qacomment: { content: @qacomment.content, qa_id: @qacomment.qa_id, user_id: @qacomment.user_id }
    end

    assert_redirected_to qacomment_path(assigns(:qacomment))
  end

  test "should show qacomment" do
    get :show, id: @qacomment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qacomment
    assert_response :success
  end

  test "should update qacomment" do
    patch :update, id: @qacomment, qacomment: { content: @qacomment.content, qa_id: @qacomment.qa_id, user_id: @qacomment.user_id }
    assert_redirected_to qacomment_path(assigns(:qacomment))
  end

  test "should destroy qacomment" do
    assert_difference('Qacomment.count', -1) do
      delete :destroy, id: @qacomment
    end

    assert_redirected_to qacomments_path
  end
end
