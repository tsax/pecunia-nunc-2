desc "Send Daily Digest of Kickstarter Projects"

task :send_daily_listing => :environment do
	DailyListingSender.send_out_daily_listing_to_all_active_subscribers
end