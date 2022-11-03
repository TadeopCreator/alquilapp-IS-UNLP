require "test_helper"

class TerminosCondicionesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get terminos_condiciones_show_url
    assert_response :success
  end
end
