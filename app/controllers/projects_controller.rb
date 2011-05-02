class ProjectsController < ApplicationController
  inherit_resources
  actions :show
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def show
    @project = Project.find(params[:id])
    @tasks = @project.user_tasks(current_user).desc(:created_at).group_by { |t| t.created_at.to_date }
    @tasks_exist = (@tasks.count == 0) ? false : true
  end
end
