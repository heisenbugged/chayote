class SnapshotsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @project = Project.find params[:project_id]
  end
end