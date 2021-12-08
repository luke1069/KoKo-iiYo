require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get following" do
    get relationships_following_url
    assert_response :success
  end

  test "should get followed" do
    get relationships_followed_url
    assert_response :success
  end

end
