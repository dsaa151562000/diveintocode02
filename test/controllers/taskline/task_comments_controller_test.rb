require 'test_helper'

class Taskline::TaskCommentsControllerTest < ActionController::TestCase
  setup do
    @taskline_task_comment = taskline_task_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taskline_task_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taskline_task_comment" do
    assert_difference('Taskline::TaskComment.count') do
      post :create, taskline_task_comment: { content: @taskline_task_comment.content, task_id: @taskline_task_comment.task_id, user_id: @taskline_task_comment.user_id }
    end

    assert_redirected_to taskline_task_comment_path(assigns(:taskline_task_comment))
  end

  test "should show taskline_task_comment" do
    get :show, id: @taskline_task_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taskline_task_comment
    assert_response :success
  end

  test "should update taskline_task_comment" do
    patch :update, id: @taskline_task_comment, taskline_task_comment: { content: @taskline_task_comment.content, task_id: @taskline_task_comment.task_id, user_id: @taskline_task_comment.user_id }
    assert_redirected_to taskline_task_comment_path(assigns(:taskline_task_comment))
  end

  test "should destroy taskline_task_comment" do
    assert_difference('Taskline::TaskComment.count', -1) do
      delete :destroy, id: @taskline_task_comment
    end

    assert_redirected_to taskline_task_comments_path
  end
end
