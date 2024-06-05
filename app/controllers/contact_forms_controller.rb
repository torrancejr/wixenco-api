class ContactFormsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.save
      render json: { message: 'Form submitted successfully' }, status: :created
    else
      render json: { errors: @contact_form.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:first_name, :last_name, :email, :phone, :budget, :website, :message)
  end
end
