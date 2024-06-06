require "test_helper"

class SiteAnalysisControllerTest < ActionDispatch::IntegrationTest
  test "should get analyze" do
    get site_analysis_analyze_url
    assert_response :success
  end
end
