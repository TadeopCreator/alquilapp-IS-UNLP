require "test_helper"

class FinalizarAlquilerControllerTest < ActionDispatch::IntegrationTest
  test "should get finalizar" do
    get finalizar_alquiler_finalizar_url
    assert_response :success
  end
end
