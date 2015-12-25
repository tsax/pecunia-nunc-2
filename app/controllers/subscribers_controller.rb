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

  private 

  def user_params
    params.require(:subscriber).permit(:name, :email, :allcategories, :art, :comics, 
                                       :crafts, :dance, :design, :fashion, :filmvideo,
                                       :food, :games, :journalism, :music, :photography, 
                                       :publishing, :technology, :theater)
  end

  def send_user_confirmation(subscriber)
    SubscriberMailer.email_confirmation(subscriber).deliver
  end
end
