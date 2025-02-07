class ContactFormsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @contact_form = ContactForm.new(contact_form_params)
    if @contact_form.save
      ContactMailer.contact_email(contact_form_params).deliver_now
      render json: { message: 'Form submitted successfully' }, status: :created
    else
      render json: { errors: @contact_form.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def contact_form_params
    params.permit(:first_name, :last_name, :email, :phone, :budget, :website, :message)
  end
end


