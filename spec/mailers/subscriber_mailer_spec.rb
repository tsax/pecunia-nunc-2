require "rails_helper"

RSpec.describe SubscriberMailer, type: :mailer do

  describe 'send daily listing', vcr: true do
    let(:subscriber) { mock_model Subscriber, name: 'Tushar', email: 'tsaxena86@gmail.com', allcategories: true }
    let(:all_projects) { VCR.use_cassette("projects") { ProjectRetriever.get_all_unfunded_projects_ending_soon } }
    let(:projects) { UserToProjectsMapper.get_category_matched_projects_for_user(subscriber, all_projects) }
    let(:mail) { SubscriberMailer.daily_listing(subscriber, projects) }
  
    it 'renders the subject' do
      expect(mail.subject).to eq('Kickstarter Projects that Need Your Help Today!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([subscriber.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["pecunia-nunc@tusharsaxena.com"])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to include(subscriber.name)
    end
  end
end
