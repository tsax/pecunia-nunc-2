require 'rails_helper'

RSpec.feature "Home page visit", type: :feature do
  scenario "User visits home page" do
    visit root_path
    expect(page).to have_text "Pecunia Nunc"
  end

  scenario "User subscribes" do
    visit root_path
    fill_in "Name", with: "Tushar S"
    page.check "All Categories"
    click_button "Subscribe!"
    expect(page).to have_text "Thanks for subscribing!"
  end

  describe "When user subscribes" do
    before(:all) do
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
  end
end