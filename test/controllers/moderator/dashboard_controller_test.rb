require "test_helper"

class Moderator::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_dashboard_index_url
    assert_response :success
  end
end
