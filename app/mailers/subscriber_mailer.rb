class SubscriberMailer < ApplicationMailer
  default from: "Pecunia Nunc <pecunia-nunc@tusharsaxena.com>"
  if Rails.env.production?
    @@request = "http://pecunia-nunc.herokuapp.com"
  else
    @@request = "http://localhost:1080"
  end
  add_template_helper(ApplicationHelper)

  def email_confirmation(subscriber)
    @subscriber = subscriber 
    mail to: @subscriber.email, subject: "Pecunia Nunc"
  end

  def daily_listing subscriber, projects
    @projects = projects
    @subscriber = subscriber
    @unsubscribe_url = "#{@@request}/unsubscribe?token=#{@subscriber.token}"
    mail to: @subscriber.email, subject: "Kickstarter Projects that Need Your Help Today!"
  end
end
