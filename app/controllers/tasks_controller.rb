class TasksController < ApplicationController
  inherit_resources
  belongs_to :project, :optional => true
  actions :new, :create, :show, :delete, :destroy, :edit, :update
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @task = Task.find(params[:id])
    @entries_exist = (@task.time_entries.count == 0) ? false : true
  end
  def create
    #raise
    @task = Task.new
    @task.user = current_user
    @project = Project.find(params[:project_id])
    @task.project = @project
    @task.name = params[:task][:name]
    create! { task_path(@task) }
  end
  def destroy
    @task = Task.find(params[:id])
    @project = @task.project
    destroy! { project_path (@project) }
  end
  def edit
    @task = Task.find(params[:id])
    @project = @task.project 
    edit!
  end
  def update
    @task = Task.find(params[:id])
    @project = @task.project
    update! { project_path(@project) }
  end
end
