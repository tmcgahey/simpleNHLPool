require 'test_helper'

class GoaliesControllerTest < ActionController::TestCase
  setup do
    @goaly = goalies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goalies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goaly" do
    assert_difference('Goalie.count') do
      post :create, goaly: { name: @goaly.name, nhl_id: @goaly.nhl_id, pool_member_id: @goaly.pool_member_id, so: @goaly.so, team: @goaly.team, wins: @goaly.wins }
    end

    assert_redirected_to goaly_path(assigns(:goaly))
  end

  test "should show goaly" do
    get :show, id: @goaly
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @goaly
    assert_response :success
  end

  test "should update goaly" do
    patch :update, id: @goaly, goaly: { name: @goaly.name, nhl_id: @goaly.nhl_id, pool_member_id: @goaly.pool_member_id, so: @goaly.so, team: @goaly.team, wins: @goaly.wins }
    assert_redirected_to goaly_path(assigns(:goaly))
  end

  test "should destroy goaly" do
    assert_difference('Goalie.count', -1) do
      delete :destroy, id: @goaly
    end

    assert_redirected_to goalies_path
  end
end
