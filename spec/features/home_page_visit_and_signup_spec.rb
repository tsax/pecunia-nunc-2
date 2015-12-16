require 'rails_helper'

RSpec.feature "Home page visit", type: :feature do
  scenario "User visits home page" do
    visit root_path
    expect(page).to have_text "Pecunia Nunc"
  end
end