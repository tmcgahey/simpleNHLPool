require 'test_helper'

class NhlTeamsControllerTest < ActionController::TestCase
  setup do
    @nhl_team = nhl_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nhl_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nhl_team" do
    assert_difference('NhlTeam.count') do
      post :create, nhl_team: { active: @nhl_team.active, name: @nhl_team.name, references: @nhl_team.references }
    end

    assert_redirected_to nhl_team_path(assigns(:nhl_team))
  end

  test "should show nhl_team" do
    get :show, id: @nhl_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nhl_team
    assert_response :success
  end

  test "should update nhl_team" do
    patch :update, id: @nhl_team, nhl_team: { active: @nhl_team.active, name: @nhl_team.name, references: @nhl_team.references }
    assert_redirected_to nhl_team_path(assigns(:nhl_team))
  end

  test "should destroy nhl_team" do
    assert_difference('NhlTeam.count', -1) do
      delete :destroy, id: @nhl_team
    end

    assert_redirected_to nhl_teams_path
  end
end
