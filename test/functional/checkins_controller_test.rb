require 'test_helper'

class CheckinsControllerTest < ActionController::TestCase
  setup do
    @checkin = checkins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checkin" do
    assert_difference('Checkin.count') do
      post :create, checkin: { checkin_time: @checkin.checkin_time, journal_id: @checkin.journal_id, latitude: @checkin.latitude, longitude: @checkin.longitude, note: @checkin.note, poi: @checkin.poi, title: @checkin.title }
    end

    assert_redirected_to checkin_path(assigns(:checkin))
  end

  test "should show checkin" do
    get :show, id: @checkin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checkin
    assert_response :success
  end

  test "should update checkin" do
    put :update, id: @checkin, checkin: { checkin_time: @checkin.checkin_time, journal_id: @checkin.journal_id, latitude: @checkin.latitude, longitude: @checkin.longitude, note: @checkin.note, poi: @checkin.poi, title: @checkin.title }
    assert_redirected_to checkin_path(assigns(:checkin))
  end

  test "should destroy checkin" do
    assert_difference('Checkin.count', -1) do
      delete :destroy, id: @checkin
    end

    assert_redirected_to checkins_path
  end
end
