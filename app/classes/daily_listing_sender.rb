class DailyListingSender
	def self.send_out_daily_listing_to_all_active_subscribers
		all_projects = ProjectRetriever.get_all_unfunded_projects_ending_soon
		subscribers = active_subscribers_eligible_for_todays_email
		
		subscribers.each do |subscriber|
			match_projects_to_subscriber_categories_and_send(all_projects, subscriber)
			puts "Daily listing sent to #{subscriber.name} : #{subscriber.email}"
		end
		puts "Task complete."
	end

	private

	def self.match_projects_to_subscriber_categories_and_send projects, subscriber
		projects_for_subscriber = UserToProjectsMapper.get_category_matched_projects_for_user(subscriber, projects)
		SubscriberMailer.daily_listing(subscriber, projects_for_subscriber).deliver_now
		subscriber.last_email = Time.now
		subscriber.save
	end

	def self.active_subscribers_eligible_for_todays_email
		Subscriber.find_active.select {|s| s.last_email.nil? || s.last_email.strftime("%F") < Time.now.strftime("%F") }
	end
end