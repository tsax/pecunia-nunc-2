class SubscribersController < ApplicationController
  def index
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(user_params)
    @subscriber.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    if @subscriber.save
      send_user_confirmation(@subscriber)
      flash[:success] = confirmation_reminder
    else
      flash[:notice] = subscribe_form_error
    end
  end

  def confirm
    @subscriber = Subscriber.find_by_token(params[:token])
    unless @subscriber.nil?
      @subscriber.active = true
      if @subscriber.save
        @message = email_confirmed_message
      else
        @message = error_message
      end
    else
      @message = account_not_found
    end
  end

  def unsubscribe
    @subscriber = Subscriber.find_by_token(params[:token])
    unless @subscriber.nil?
      @subscriber.active = false
      if @subscriber.save
        @message = unsusbcribe_message 
      else
        @message = error_message
      end
    else
      @message = account_not_found
    end
  end
  

  private 

  def user_params
    params.require(:subscriber).permit(:name, :email, :allcategories, :art, :comics, 
                                       :crafts, :dance, :design, :fashion, :filmvideo,
                                       :food, :games, :journalism, :music, :photography, 
                                       :publishing, :technology, :theater)
  end

  def send_user_confirmation(subscriber)
    SubscriberMailer.email_confirmation(subscriber).deliver_now
  end

  def subscribe_form_error
    "There were errors! Please resubmit after making corrections"
  end

  def confirmation_reminder
    "Thanks for signing up! Please confirm your email address by confirming the email sent to your inbox shortly!"
  end

  def email_confirmed_message
    "Thanks! Your e-mail address has been confirmed!"
  end
  
  def unsusbcribe_message
    "Sorry to see you go! You've been unsubscribed"
  end

  def error_message
    "Sorry, there was an error"
  end

  def account_not_found
    "Sorry, your account could not be found, Please contact pecunia-nunc@tusharsaxena.com"
  end
end
