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
end