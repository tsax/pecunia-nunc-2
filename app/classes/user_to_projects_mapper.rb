class UserToProjectsMapper

  def get_projects
    ProjectRetriever.get_all_unfunded_projects_ending_soon
  end

  def get_category_matched_projects_for_user user
    categories = user_categories(user)
    projects = get_projects
    if categories.include? 'All'
      return projects
    else
      return projects.select { |p| project_in_users_category?(categories, p) }
    end
  end 

  def project_in_users_category? categories, project
    categories.include?(project.category.split('/').first)
  end

  def user_categories user
    categories = []
    if user.allcategories ; categories << 'All' ; return categories end
    if user.art ; categories << 'Art' end
    if user.comics ; categories << 'Comics' end
    if user.crafts ; categories << 'Crafts' end
    if user.dance ; categories << 'Dance' end
    if user.design ; categories << 'Design' end
    if user.fashion ; categories << 'Fashion' end
    if user.filmvideo ; categories << 'Film & Video' end
    if user.food ; categories << 'Food' end
    if user.games ; categories << 'Games' end
    if user.journalism ; categories << 'Journalism' end
    if user.music ; categories << 'Music' end
    if user.photography ; categories << 'Photography' end
    if user.publishing ; categories << 'Publishing' end
    if user.technology ; categories << 'Technology' end
    if user.theater ; categories << 'Theater' end
    categories
  end
  
end