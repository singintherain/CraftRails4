class ContactForm < MailForm::Base
  attributes :name, :email, :message

  def initialize(attributes = {})
    attributes.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if attributes
  end

  def headers
    { to: 'recipient@example.com', from: self.email }
  end
end
