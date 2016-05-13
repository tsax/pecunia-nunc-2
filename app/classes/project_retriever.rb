require 'kickstarter'

class ProjectRetriever
  def self.get_all_unfunded_projects_ending_soon
    get_all_live_projects_between_75_and_100_percent_funded.select do |pr|
      ending_soon?(pr) && above_pledge_threshold?(pr)
    end 
  end

  def self.get_all_live_projects_between_75_and_100_percent_funded
    projects = Kickstarter.by_list_ending_soon(pages: :all)
  end

  private

  def self.ending_soon? project
    project.pledge_deadline.strftime("%F") < three_days_ahead.strftime("%F")
  end

  def self.above_pledge_threshold? project
    project.pledge_percent > pledge_threshold
  end

  def self.three_days_ahead
    Time.now + 3 * 24 * 60 * 60
  end

  def self.pledge_threshold
    79.9
  end
end