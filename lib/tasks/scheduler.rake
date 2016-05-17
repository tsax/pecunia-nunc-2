desc "Send Daily Digest of Kickstarter Projects"
task :send_daily_listing => :environment do
	DailyListingSender.send_out_daily_listing_to_all_active_subscribers
end

desc "This task tests methods of the Project object and sends email if any used method errors out"
task :pre_send_property_test => :environment do 
	project = ProjectRetriever.get_all_unfunded_projects_ending_soon.sample
	error_hash = Hash.new

	error_hash[:name] = project.name.nil? rescue 'nil'
	error_hash[:url] = project.url.nil? rescue 'nil'
	error_hash[:owner] = project.owner.nil? rescue 'nil'
	error_hash[:thumbnail] = project.thumbnail_url.nil? rescue 'nil'
	error_hash[:description] = project.description.nil? rescue 'nil'
	error_hash[:pledge_percent] = project.pledge_percent.nil? rescue 'nil'
	error_hash[:category] = project.category.nil? rescue 'nil'
	error_hash[:pledge_deadline] = project.pledge_deadline.nil? rescue 'nil'

	if error_hash.values.any? {|value| value == 'nil'}
		ReportingMailer.project_errors_email(error_hash.select {|k,v| v == 'nil'}.keys).deliver
	end
end