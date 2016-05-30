module ApplicationHelper
	def subscriber_name_titleized subscriber
		subscriber.name.split(' ')[0].titleize
	end

	def primary_category_url project
		"https://www.kickstarter.com/discover/categories/#{project.category.split('/').first}"
	end

	def progress_bar_pledge_percent project
		project.pledge_percent > 100? 100: project.pledge_percent
	end

	def hours_left deadline
		((deadline - Time.now)/3600).round
	end
end
