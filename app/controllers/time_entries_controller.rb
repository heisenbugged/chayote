class TimeEntriesController < ApplicationController
  inherit_resources
  belongs_to :task, :optional => true
  actions :create, :new, :delete, :destroy
  before_filter :authenticate_user!
  def create
    params[:time_entry][:user_id] = current_user.id
    create! { task_path(params[:task_id] )}
  end
  def destroy
    @task = TimeEntry.find(params[:id]).task
    destroy! { task_path @task }
  end
end
