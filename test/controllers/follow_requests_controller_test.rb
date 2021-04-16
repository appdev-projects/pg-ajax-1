require "test_helper"

class FollowRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @follow_request = follow_requests(:one)
  end

  test "should get index" do
    get follow_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_follow_request_url
    assert_response :success
  end

  test "should create follow_request" do
    assert_difference('FollowRequest.count') do
      post follow_requests_url, params: { follow_request: { recipient_id: @follow_request.recipient_id, sender_id: @follow_request.sender_id, status: @follow_request.status } }
    end

    assert_redirected_to follow_request_url(FollowRequest.last)
  end

  test "should show follow_request" do
    get follow_request_url(@follow_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_follow_request_url(@follow_request)
    assert_response :success
  end

  test "should update follow_request" do
    patch follow_request_url(@follow_request), params: { follow_request: { recipient_id: @follow_request.recipient_id, sender_id: @follow_request.sender_id, status: @follow_request.status } }
    assert_redirected_to follow_request_url(@follow_request)
  end

  test "should destroy follow_request" do
    assert_difference('FollowRequest.count', -1) do
      delete follow_request_url(@follow_request)
    end

    assert_redirected_to follow_requests_url
  end
end
