class DailyListingSender
	def self.send_out_daily_listing_to_all_active_subscribers
		all_projects = ProjectRetriever.get_all_unfunded_projects_ending_soon
		subscribers = Subscriber.where(active: true).select {|s| s.last_email.strftime("%F") < Time.now.strftime("%F") }
		
		subscribers.each do |subscriber|
			projects_for_subscriber = UserToProjectsMapper.get_category_matched_projects_for_user(subscriber, all_projects)
			SubscriberMailer.daily_listing(subscriber, projects_for_subscriber).deliver_now
			subscriber.last_email = Time.now
			subscriber.save
			puts "Daily listing sent to #{subscriber.name} : #{subscriber.email}"
		end
		puts "All emails sent."
	end
end