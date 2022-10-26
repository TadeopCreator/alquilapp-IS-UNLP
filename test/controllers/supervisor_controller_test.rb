require "test_helper"

class SupervisorControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get supervisor_dashboard_url
    assert_response :success
  end
end
