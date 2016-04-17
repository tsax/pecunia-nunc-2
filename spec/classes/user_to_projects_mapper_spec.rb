require 'rails_helper'

RSpec.describe UserToProjectsMapper do
  let(:subscriber) { mock_model Subscriber, name: 'Tushar', email: 'tsaxena86@gmail.com', allcategories: true }
  let(:projects) { described_class.new.get_category_matched_projects_for_user(subscriber) }

  # it "contains certain projects" do
  #   projects.
  # end
end
