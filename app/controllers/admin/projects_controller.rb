class Admin::ProjectsController < ApplicationController
  inherit_resources
  actions :index, :new, :create, :edit, :update, :destroy
  before_filter :authenticate_user!
  def update
    @project = Project.find(params[:id])
    unless params[:users].blank?
      @project.users = params[:users]      
    end
    update! { admin_projects_url }
  end
  def create
    create! { admin_projects_url }  
  end
  def index
    @projects = Project.desc(:_id)
  end
  def add_user    
    unless params[:user].blank?
      @project = Project.find(params[:id])
      @user = User.find(params[:user])

      @member = Member.new
      @member.user = @user
      @member.project = @project
      (params[:rate].blank?) ? @member.rate = @user.base_rate : @member.rate = params[:rate]
      @member.save
          
      redirect_to edit_admin_project_url @project
    else
      redirect_to edit_admin_project_url @project
    end
  end
  #TODO: Find native way to do this
  def remove_user
    @member = Member.find(params[:id])
    @member.delete
    redirect_to edit_admin_project_url @project
  end
end
