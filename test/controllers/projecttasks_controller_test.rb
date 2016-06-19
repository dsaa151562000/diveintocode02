require 'test_helper'

class ProjecttasksControllerTest < ActionController::TestCase
  setup do
    @projecttask = projecttasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projecttasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projecttask" do
    assert_difference('Projecttask.count') do
      post :create, projecttask: { project_id: @projecttask.project_id, projecttask_charge_id: @projecttask.projecttask_charge_id, projecttask_content: @projecttask.projecttask_content, projecttask_deadline: @projecttask.projecttask_deadline, projecttask_done: @projecttask.projecttask_done, projecttask_status: @projecttask.projecttask_status, projecttask_title: @projecttask.projecttask_title, user_id: @projecttask.user_id }
    end

    assert_redirected_to projecttask_path(assigns(:projecttask))
  end

  test "should show projecttask" do
    get :show, id: @projecttask
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @projecttask
    assert_response :success
  end

  test "should update projecttask" do
    patch :update, id: @projecttask, projecttask: { project_id: @projecttask.project_id, projecttask_charge_id: @projecttask.projecttask_charge_id, projecttask_content: @projecttask.projecttask_content, projecttask_deadline: @projecttask.projecttask_deadline, projecttask_done: @projecttask.projecttask_done, projecttask_status: @projecttask.projecttask_status, projecttask_title: @projecttask.projecttask_title, user_id: @projecttask.user_id }
    assert_redirected_to projecttask_path(assigns(:projecttask))
  end

  test "should destroy projecttask" do
    assert_difference('Projecttask.count', -1) do
      delete :destroy, id: @projecttask
    end

    assert_redirected_to projecttasks_path
  end
end
