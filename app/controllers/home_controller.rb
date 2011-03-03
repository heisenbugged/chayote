class HomeController < ApplicationController
  def index
    if user_signed_in?
      @projects = current_user.projects
      @projects_exist = (current_user.projects.count > 0) ? true : false
    else
      redirect_to new_user_session_path
    end
  end
end
