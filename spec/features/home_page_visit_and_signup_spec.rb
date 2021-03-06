require 'rails_helper'

RSpec.feature "Home page visit", type: :feature do
  scenario "User visits home page" do
    visit root_path
    expect(page).to have_text "Pecunia Nunc"
  end

  describe "When user subscribes" do
    before(:all) do
      ActionMailer::Base.deliveries.clear
      visit root_path
      fill_in "Name", with: "Dummy"
      fill_in "Email", with: "dummy@dummy.com"
      page.check "All Categories"
      click_button "Subscribe!"
    end

    scenario "should have confirmation text" do
      expect(page).to have_text "Thanks for subscribing!"
    end

    scenario "a confirmation email should be sent" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    after(:all) do
      Subscriber.find_by_email("dummy@dummy.com").delete
    end
  end

  describe "Subscribing, unsubscribing & re-subscribing" do
    before(:all) do
      @subscriber = Subscriber.new(name: "hehe", email: "dd@dummy.com", allcategories: true)
      @subscriber.token = Digest::SHA1.hexdigest([Time.now, rand].join)
      @subscriber.save
    end
    
    scenario "User clicks the 'change categories' link" do
      visit "/subscribers/change_preferences?token=#{@subscriber.token}"
      expect(page).to have_text "Select your categories"
    end

    scenario "User changes categories in the form" do
      visit "/subscribers/change_preferences?token=#{@subscriber.token}"
      page.check "All Categories"
      # PENDING, finish this.
    end

    scenario "User clicks the confirmation link" do
      visit "/subscribers/confirm?token=#{@subscriber.token}"
      expect(page).to have_text "Thanks! Your e-mail address has been confirmed!"
    end

    scenario "User clicks the unsubscribe link" do
      visit "/unsubscribe?token=#{@subscriber.token}"
      expect(page).to have_text "Sorry to see you go! You've been unsubscribed"
    end

    scenario "Unsubscribed user re-submits subscription form" do
      visit "/subscribers/confirm?token=#{@subscriber.token}"
      expect(page).to have_text "Thanks! Your e-mail address has been confirmed!"
    end
    
    scenario
    after(:all) do
      Subscriber.find_by_email("dd@dummy.com").delete
    end
  end
end