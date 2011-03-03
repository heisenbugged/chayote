class Admin::MembersController < ApplicationController
  inherit_resources
  actions :create, :update, :destroy
  before_filter :authenticate_user!
  def create    
    @project = Project.find(params[:member][:project])
    unless params[:rate].blank?
      @rate = ProjectRate.new
      @rate.project = @project
      @rate.user = User.find(params[:member][:user])
      @rate.amount = params[:rate]
      @rate.save!
    end
    create! { edit_admin_project_url @project }

  end
  def destroy    
    @project = Member.find(params[:id]).project
    destroy!{ edit_admin_project_url @project }
  end
end
