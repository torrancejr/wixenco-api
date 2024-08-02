class ContactMailer < ApplicationMailer
  default from: 'your_email@example.com'

  def contact_email(form_data)
    @form_data = form_data
    mail(to: @form_data[:email], subject: 'Contact Form Submission')
  end
end
