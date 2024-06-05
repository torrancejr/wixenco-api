require "test_helper"

class ContactFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_form = contact_forms(:one)
  end

  test "should get index" do
    get contact_forms_url, as: :json
    assert_response :success
  end

  test "should create contact_form" do
    assert_difference("ContactForm.count") do
      post contact_forms_url, params: { contact_form: { budget: @contact_form.budget, email: @contact_form.email, first_name: @contact_form.first_name, last_name: @contact_form.last_name, message: @contact_form.message, phone: @contact_form.phone, website: @contact_form.website } }, as: :json
    end

    assert_response :created
  end

  test "should show contact_form" do
    get contact_form_url(@contact_form), as: :json
    assert_response :success
  end

  test "should update contact_form" do
    patch contact_form_url(@contact_form), params: { contact_form: { budget: @contact_form.budget, email: @contact_form.email, first_name: @contact_form.first_name, last_name: @contact_form.last_name, message: @contact_form.message, phone: @contact_form.phone, website: @contact_form.website } }, as: :json
    assert_response :success
  end

  test "should destroy contact_form" do
    assert_difference("ContactForm.count", -1) do
      delete contact_form_url(@contact_form), as: :json
    end

    assert_response :no_content
  end
end
