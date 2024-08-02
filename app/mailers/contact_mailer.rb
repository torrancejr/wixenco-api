class ContactMailer < ApplicationMailer
  default from: 'ryan@wixenco.com'

  def contact_email(form_data)
    @form_data = form_data
    mail(to: "torrance.jr@gmail.com", subject: 'Contact Form Submission')
  end
end
