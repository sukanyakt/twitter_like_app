require 'test_helper'

class FollowControllerTest < ActionDispatch::IntegrationTest
  test "should get follow" do
    get follow_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get follow_unfollow_url
    assert_response :success
  end

end
