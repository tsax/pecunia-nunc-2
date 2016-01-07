class SubscriberMailer < ApplicationMailer
  default from: "Pecunia Nunc <pecunia-nunc@tusharsaxena.com>"
  @@request = "http://pecunia-nunc.herokuapp.com"

  def email_confirmation(subscriber)
    @subscriber = subscriber 
    mail to: @subscriber.email, subject: "Pecunia Nunc"
  end
end