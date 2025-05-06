require "test_helper"

class DiscussionThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get discussion_threads_index_url
    assert_response :success
  end

  test "should get show" do
    get discussion_threads_show_url
    assert_response :success
  end

  test "should get new" do
    get discussion_threads_new_url
    assert_response :success
  end

  test "should get create" do
    get discussion_threads_create_url
    assert_response :success
  end
end
