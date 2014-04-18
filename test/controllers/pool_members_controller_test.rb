require 'test_helper'

class PoolMembersControllerTest < ActionController::TestCase
  setup do
    @pool_member = pool_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pool_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pool_member" do
    assert_difference('PoolMember.count') do
      post :create, pool_member: { name: @pool_member.name, pool_id: @pool_member.pool_id }
    end

    assert_redirected_to pool_member_path(assigns(:pool_member))
  end

  test "should show pool_member" do
    get :show, id: @pool_member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pool_member
    assert_response :success
  end

  test "should update pool_member" do
    patch :update, id: @pool_member, pool_member: { name: @pool_member.name, pool_id: @pool_member.pool_id }
    assert_redirected_to pool_member_path(assigns(:pool_member))
  end

  test "should destroy pool_member" do
    assert_difference('PoolMember.count', -1) do
      delete :destroy, id: @pool_member
    end

    assert_redirected_to pool_members_path
  end
end
