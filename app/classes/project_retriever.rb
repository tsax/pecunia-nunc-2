require 'kickstarter'

class ProjectRetriever
  def get_all_projects_ending_soon
    projects = Kickstarter.by_list_ending_soon(pages: :all).select do |proj|
      proj.pledge_deadline.strftime("%F") < (Time.now + 3*24*60*60).strftime("%F") && proj.pledge_percent > 79.9
    end
  end
end