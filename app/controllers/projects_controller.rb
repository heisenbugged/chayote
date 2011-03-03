class ProjectsController < ApplicationController
  inherit_resources
  actions :show
  before_filter :authenticate_user!

  def show
    @project = Project.find(params[:id])
    @tasks = @project.user_tasks(current_user).desc(:_id)
    @tasks_exist = (@tasks.count == 0) ? false : true
  end
end
