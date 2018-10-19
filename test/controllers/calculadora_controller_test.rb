require 'test_helper'

class CalculadoraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calculadora_index_url
    assert_response :success
  end

end
