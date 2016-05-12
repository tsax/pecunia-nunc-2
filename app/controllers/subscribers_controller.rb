class SubscribersController < ApplicationController
  def index
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(user_params)
    if @subscriber.save
      send_user_confirmation(@subscriber)
      flash[:success] = "Thanks for signing up! Please confirm your email address by confirming the email sent to your inbox shortly!"
    else
      flash[:notice] = "There were errors! Please resubmit after making corrections"
    end
  end

  def confirm
    @subscriber = Subscriber.find_by_token(params[:token])
    unless @subscriber.nil?
      @subscriber.active = true
      if @subscriber.save
        @message = "Thanks! Your e-mail address has been confirmed!"
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
        @message = "Sorry to see you go! You've been unsubscribed" 
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

  def error_message
    "Sorry, there was an error"
  end

  def account_not_found
    "Sorry, your account could not be found, Please contact pecunia-nunc@tusharsaxena.com"
  end
end
