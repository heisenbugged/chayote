class InvoiceController < ApplicationController
  before_filter :authenticate_user!
  #authorize_resource, :class => false
  def new
    authorize! :invoice, current_user
    @projects = Project.all
  end
  def show
    authorize! :invoice, current_user
    @start_date = Time.parse(params[:start_date])
    @end_date = Time.parse(params[:end_date])
    @project = Project.find(params[:project])
    #@time_entries = TimeEntry.where(:date.gte => @start_date, :date.lte => @end_date)
  end
end
