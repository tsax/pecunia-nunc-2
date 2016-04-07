require "rails_helper"

RSpec.describe SubscriberMailer, type: :mailer do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'send daily listing' do
    let(:user) { mock_model Subscriber, name: 'Tushar', email: 'tsaxena86@gmail.com', allcategories: true }
    let(:projects) { UserToProjectsMapper.new.get_category_matched_projects_for_user(user)}
    let(:mail) { SubscriberMailer.daily_listing(user, projects) }
  
    it 'renders the subject' do
      expect(mail.subject).to eql('Whatevah!')
    end
  end
end
