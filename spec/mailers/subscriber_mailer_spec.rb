require "rails_helper"

RSpec.describe SubscriberMailer, type: :mailer do

  describe 'send daily listing' do
    let(:subscriber) { mock_model Subscriber, name: 'Tushar', email: 'tsaxena86@gmail.com', allcategories: true }
    let(:projects) { UserToProjectsMapper.new.get_category_matched_projects_for_user(subscriber)}
    let(:mail) { SubscriberMailer.daily_listing(subscriber, projects) }
  
    it 'renders the subject' do
      expect(mail.subject).to eq('Whatevah!')
    end
  end
end
