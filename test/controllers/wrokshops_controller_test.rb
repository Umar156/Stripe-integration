require "test_helper"

class WorkshopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get Workshops_index_url
    assert_response :success
  end

  test "should get show" do
    get Workshops_show_url
    assert_response :success
  end
end
