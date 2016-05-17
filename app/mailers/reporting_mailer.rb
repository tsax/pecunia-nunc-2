class ReportingMailer < ActionMailer::Base
  default from: "Pecunia Nunc <pecunia-nunc@tusharsaxena.com>"
  if Rails.env.production?
    @@request = "http://pn2.herokuapp.com"
  else
    @@request = "http://pecunia-nunc.dev"
  end

  def project_errors_email(errors)
    @errors = errors
    mail to: "tsaxena86@gmail.com", subject: "Errors! Fix Before Listing Sendout"
  end
end
