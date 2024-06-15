require "test_helper"

class ChatbotControllerTest < ActionDispatch::IntegrationTest
  test "should get respond" do
    get chatbot_respond_url
    assert_response :success
  end
end
