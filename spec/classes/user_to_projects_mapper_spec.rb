require 'rails_helper'

RSpec.describe UserToProjectsMapper, vcr: true do
  let(:subscriber_all) { mock_model Subscriber, name: 'Tushar', email: 'tsaxena86@gmail.com', allcategories: true }
  let(:subscriber_music) { mock_model Subscriber, name: 'Tushar Music', email: 'tsaxena86@gmail.com', music: true }
  let(:subscriber_film) { mock_model Subscriber, name: 'Tushar Film', email: 'tsaxena86@gmail.com', filmvideo: true }
  
  let(:projects_all) { VCR.use_cassette("projects") { described_class.new.get_category_matched_projects_for_user(subscriber_all) } }
  let(:projects_music) { VCR.use_cassette("projects") { described_class.new.get_category_matched_projects_for_user(subscriber_music) } }
  let(:projects_film) { VCR.use_cassette("projects") { described_class.new.get_category_matched_projects_for_user(subscriber_film) } }
  
  it "Subscriber to all categories receives all projects ending soon above threshold" do 
  	
  end

  it "Subscriber to music only receives music-based projects" do 
  	expect(projects_music.any? { |p| p.category.include? 'Music' }).to be false
  end

  it "Subscriber to film only receives film-based projects" do
  	expect(projects_film.any? { |p| p.category.exclude? 'Film' }).to be false
  end
end
